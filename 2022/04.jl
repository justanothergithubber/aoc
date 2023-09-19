include("day_setup.jl")  # puts DAY_DATA into namespace

function get_day_data_as_ranges(
    input_substring::Vector{SubString{String}},
)::Tuple{UnitRange{Int},UnitRange{Int}}
    values_vec::Vector{Int} = parse.(Int, input_substring)
    return (
        range(values_vec[1], values_vec[2]),
        range(values_vec[3], values_vec[4]),
    )
end

const DAY_DATA_VECTOR_TUPLES::Vector{
    Tuple{UnitRange{Int},UnitRange{Int}},
} = get_day_data_as_ranges.(split.(DAY_DATA, r"[,-]"))  # regex for , or -

function check_if_fully_contains(
    input_tuple::Tuple{UnitRange{Int},UnitRange{Int}},
)::Bool
    ran_1 = input_tuple[1]
    ran_2 = input_tuple[2]
    return (ran_1 ⊆ ran_2) | (ran_2 ⊆ ran_1)
end

function check_if_contains(
    input_tuple::Tuple{UnitRange{Int},UnitRange{Int}},
)::Bool
    ran_1 = input_tuple[1]
    ran_2 = input_tuple[2]
    return !isempty(ran_1 ∩ ran_2)
end

function part1()::Int
    return sum(check_if_fully_contains.(DAY_DATA_VECTOR_TUPLES))
end

function part2()::Int
    return sum(check_if_contains.(DAY_DATA_VECTOR_TUPLES))
end

println(part1())
println(part2())
