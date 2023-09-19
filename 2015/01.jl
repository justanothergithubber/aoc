include("day_setup.jl")  # puts DAY_DATA into namespace

const FIRST_DAY_DATA::String = DAY_DATA[1]
const UP_DOWN_DICT = Dict(
    '(' => 1,
    ')' => -1        
)

function part1()::Int
    current_level::Int = 0
    for s in FIRST_DAY_DATA
        current_level += UP_DOWN_DICT[s]
    end
    return current_level
end

function part2()::Int
    current_level::Int = 0
    idx::Int = 0
    for s in FIRST_DAY_DATA
        idx += 1
        current_level += UP_DOWN_DICT[s]
        if current_level == -1
            return idx
        end
    end
end

println(part1())
println(part2())
