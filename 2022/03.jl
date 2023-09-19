include("day_setup.jl")  # puts DAY_DATA into namespace

const ALPHABETS::String = String(vcat('a':'z', 'A':'Z'))

function find_single_string_common_idx(input_string::String)::Int
    str_len::Int = length(input_string)
    middle::Int = str_len ÷ 2
    common_letter::Char =
        only(∩(input_string[1:middle], input_string[middle+1:end]))
    return findfirst(common_letter, ALPHABETS)
end

function find_common_str_in_three(input_vec_str::Vector{String})::Int
    total::Int = 0
    for i in range(start = 1, stop = length(input_vec_str), step = 3)
        total += findfirst(only(∩(DAY_DATA[i:i+2]...)), ALPHABETS)
    end
    return total
end

function part1()::Int
    return sum(find_single_string_common_idx.(DAY_DATA))
end

function part2()::Int
    return find_common_str_in_three(DAY_DATA)
end

println(part1())
println(part2())
