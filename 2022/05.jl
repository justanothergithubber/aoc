include("day_setup.jl")  # puts DAY_DATA into namespace

### DATA PROCESSING ###
# Crate index constants
const LAST_CRATE_INDEX::Int = 8
const FIRST_MOVE_INDEX::Int = 11
const NUM_CRATES::Int = (length(DAY_DATA[begin]) + 1) ÷ 4

"""Get the index of a crate."""
function get_crate_indices(input_data::String)::Vector{Int}
    return (getfield.(findall("[", input_data), :start) .+ 1)
end
const CRATE_INDICES::Vector{Vector{Int}} =
    get_crate_indices.(DAY_DATA[begin:LAST_CRATE_INDEX])

# Move constants
const MOVE_DICT::NTuple{3,Pair{String,String}} =
    ("move " => "", "from " => "", "to " => "")
const MOVES::Vector{Tuple{Int,Int,Int}} = [
    Tuple(parse.(Int, v)) for v in
    split.(replace.(DAY_DATA[FIRST_MOVE_INDEX:end], MOVE_DICT...))
]

function get_crates_data()::Vector{String}
    out_crates::Vector{String} = fill("", NUM_CRATES)
    for (row_idx, i) in enumerate(CRATE_INDICES)
        for j in i
            crate_idx = (j + 2) ÷ 4
            out_crates[crate_idx] =
                DAY_DATA[row_idx][j] * out_crates[crate_idx]
        end
    end
    return out_crates
end

const INPUT_CRATES_DATA::Vector{String} = get_crates_data()
### END DATA PROCESSING ###

function move_crates(
    to_be_modified_crates::Vector{String},
    move::NTuple{3,Int},
    part_function,
)
    num_to_move = move[1]
    move_crate_idx = move[2]
    to_add_crate_idx = move[3]
    to_move_crate = to_be_modified_crates[move_crate_idx]
    to_be_modified_crates[to_add_crate_idx] =
        to_be_modified_crates[to_add_crate_idx] *
        part_function(to_move_crate[end-num_to_move+1:end])
    to_move_crate = to_move_crate[begin:end-num_to_move]
    to_be_modified_crates[move_crate_idx] = to_move_crate
    return to_be_modified_crates
end

function part1(input_part_crates::Vector{String})::String
    part_crates = copy(input_part_crates)
    # or use foldl but required to define the partial functions
    for move in MOVES
        part_crates = move_crates(part_crates, move, reverse)
    end
    return String(last.(part_crates))
end

function part2(input_part_crates::Vector{String})::String
    part_crates = copy(input_part_crates)
    for move in MOVES
        part_crates = move_crates(part_crates, move, identity)
    end
    return String(last.(part_crates))
end

println(part1(INPUT_CRATES_DATA))
println(part2(INPUT_CRATES_DATA))
