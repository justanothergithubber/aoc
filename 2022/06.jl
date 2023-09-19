include("day_setup.jl")  # puts DAY_DATA into namespace

const DAY_DATA_STRING::String = DAY_DATA[1]

function get_marker(
    input_market_length::Int,
    input_starting_idx::Int = 1,
)
    for idx =
        input_starting_idx:length(
            DAY_DATA_STRING,
        )-input_market_length+1
        if length(
            Set(DAY_DATA_STRING[idx:idx+input_market_length-1]),
        ) == input_market_length
            return idx + input_market_length - 1
        end
    end
end

function part1()::Int
    return get_marker(4)
end

function part2(part_starting_idx::Int)
    return get_marker(14, part_starting_idx)
end

const part1idx::Int = part1()
println(part1idx)
println(part2(part1idx))
