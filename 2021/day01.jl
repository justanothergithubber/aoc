include("day_setup.jl")  # puts DAY_DATA into namespace

const DAY_DATA_INT::Vector{Int} = parse.(Int, DAY_DATA)
const WINDOW::Int = 3

function part1()::Int
    counter::Int = 0
    last_num = Inf
    for num in DAY_DATA_INT
        if num > last_num
            counter += 1
        end
        last_num = num
    end
    return counter
end

function part2()::Int
    counter::Int = 0
    last_rolling_sum = Inf
    for index in 1:length(DAY_DATA_INT[1:length(DAY_DATA_INT)-WINDOW+1])
        rolling_sum = (sum(DAY_DATA_INT[index:index+WINDOW-1]))
        if rolling_sum > last_rolling_sum
            counter += 1
        end
        last_rolling_sum = rolling_sum
    end
    return counter
end

println(part1())
println(part2())
