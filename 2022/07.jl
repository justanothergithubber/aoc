include("day_setup.jl")  # puts DAY_DATA into namespace

const SPACE_THRESHOLD::Int = 100000
const AVAILABLE_SPACE::Int = 70000000
const UPDATE_REQUIRED_SPACE::Int = 30000000

function compute_directory_sizes()::Dict{Vector{String},Int}
    func_directory_sizes::Dict{Vector{String},Int} = Dict()
    cur_directory::Vector{String} = []
    for line in DAY_DATA
        if startswith(line, "\$ cd ")  # if changing directory
            target_dir = split(line)[3]
            if !(target_dir == "..")
                push!(cur_directory, target_dir)
                func_directory_sizes[copy(cur_directory)] = 0
            else
                pop!(cur_directory)
            end
        elseif occursin(r"\d", line)  # if it is a file with a size
            filesize::Int = parse(Int, split(line)[1])
            for (idx, _) in enumerate(cur_directory)
                func_directory_sizes[cur_directory[1:idx]] += filesize
            end
        end
    end
    return func_directory_sizes
end

const directory_sizes::Dict{Vector{String},Int} =
    compute_directory_sizes()

function part1()::Int
    return sum(
        values(
            filter(
                kv -> kv.second <= SPACE_THRESHOLD,
                directory_sizes,
            ),
        ),
    )
end

function part2()::Int
    delete_space_threshold::Int =
        directory_sizes[["/"]] + UPDATE_REQUIRED_SPACE -
        AVAILABLE_SPACE
    return minimum(
        values(
            filter(
                kv -> kv.second >= delete_space_threshold,
                directory_sizes,
            ),
        ),
    )
end

println(part1())
println(part2())
