include("day_setup.jl")  # puts DAY_DATA into namespace

const DIRECTION_DICT::Dict{String,Int} = Dict(["forward" => 1, "down" => 1, "up" => -1])
const AXIS_DICT::Dict{String,Int} = Dict(["forward" => 1, "down" => 2, "up" => 2])

function line_to_increment(input_line::String)::Vector{Int64}
    starting_position = [0; 0]  # for each line, assume relative to origin
    direction_str, steps_str = split(input_line)
    direction = DIRECTION_DICT[direction_str]
    axis = AXIS_DICT[direction_str]
    steps = parse(Int, steps_str)
    starting_position[axis] += direction * steps
    return starting_position
end

function part1()::Int
    return prod(sum(line_to_increment.(DAY_DATA)))
end

function part2()::Int
    horizontal_position = 0
    depth = 0
    aim = 0
    for line in DAY_DATA
        direction, change_str = split(line)
        change_amount = parse(Int, change_str)
        if direction in ("up", "down")
            aim += (2 * (direction == "down") - 1) * change_amount
        else
            horizontal_position += change_amount
            depth += aim * change_amount
        end
    end
    return horizontal_position * depth
end

println(part1())
println(part2())
