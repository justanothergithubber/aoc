include("day_setup.jl")  # puts DAY_DATA into namespace

const PartOneDict::Base.ImmutableDict{String,Int} = Base.ImmutableDict(
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6,
)

const PartTwoDict::Base.ImmutableDict{String,Int} = Base.ImmutableDict(
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7,
)

function part1()::Int
    return sum(getindex.(Ref(PartOneDict), DAY_DATA))
end

function part2()::Int
    return sum(getindex.(Ref(PartTwoDict), DAY_DATA))
end

println(part1())
println(part2())
