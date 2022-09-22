include("day_setup.jl")  # puts DAY_DATA into namespace

const DRAWN_NUMBERS::Vector{Int} = parse.(Int, split(DAY_DATA[1], ','))
const BINGO_LENGTH::Int = length(split(DAY_DATA[3], keepempty=false))
BingoBoard = Matrix{Int}

function read_in_bingo_boards(input_vec::Vector{String})::Vector{BingoBoard}
    output = Vector{BingoBoard}()
    for bingo_start_index in (2:(BINGO_LENGTH+1):length(input_vec))
        bingo_str = input_vec[bingo_start_index:bingo_start_index+BINGO_LENGTH-1]
        bingo_board = parse.(
            Int,
            permutedims(reduce(hcat, split.(bingo_str, keepempty=false)))
        )
        push!(output, bingo_board)
    end
    return output
end

const BINGO_BOARDS::Vector{BingoBoard} = read_in_bingo_boards(DAY_DATA[2:end])

function check_bingo_win(input_bingo_drawn::BitMatrix)::Bool
    return (BINGO_LENGTH in sum(input_bingo_drawn, dims=1)) ||
           (BINGO_LENGTH in sum(input_bingo_drawn, dims=2))
end

function part1and2()::NTuple{2,Int}
    num_bingo_boards = length(BINGO_BOARDS)
    not_yet_won_idxes = collect(1:num_bingo_boards)
    first_winning_number = 0
    first_winning_bingo_idx = 0
    not_yet_first_won = true
    last_winning_number = 0
    last_winning_bingo_idx = 0
    bingo_states = [
        BitMatrix(fill(false, 5, 5)) for _ in 1:num_bingo_boards
    ]
    for draw in DRAWN_NUMBERS
        to_remove = Vector{Int}()
        for bingo_board_idx in not_yet_won_idxes
            bingo_board = BINGO_BOARDS[bingo_board_idx]
            bingo_num_idx = findfirst(==(draw), bingo_board)
            if !isnothing(bingo_num_idx)
                bingo_states[bingo_board_idx][bingo_num_idx] = 1
            end
            if check_bingo_win(bingo_states[bingo_board_idx])
                push!(to_remove, bingo_board_idx)
                if not_yet_first_won
                    first_winning_number = draw
                    first_winning_bingo_idx = bingo_board_idx
                    not_yet_first_won = false
                else
                    last_winning_number = draw
                    last_winning_bingo_idx = bingo_board_idx
                end
            end
        end
        setdiff!(not_yet_won_idxes, to_remove)
    end
    first_winning_score = first_winning_number *
                          sum(BINGO_BOARDS[first_winning_bingo_idx] .*
                              .!bingo_states[first_winning_bingo_idx])
    last_winning_score = last_winning_number *
                         sum(BINGO_BOARDS[last_winning_bingo_idx] .*
                             .!bingo_states[last_winning_bingo_idx])
    return (first_winning_score, last_winning_score)
end

println(part1and2())
