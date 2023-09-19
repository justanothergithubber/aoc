include("day_setup.jl")  # puts DAY_DATA into namespace

"""Constant denoting how many top to be included."""
const K::Int = 3

function part1and2()::NTuple{2,Int}
    top_k = Vector{Int}(undef, K)  # top K calories
    single_elf_calories = Vector{Int}(undef, 0)
    for process_string in DAY_DATA
        if process_string == ""  # end of elf calory list
            sum_elf = sum(single_elf_calories)
            if sum_elf > top_k[1]
                for (index, value) in
                    Iterators.reverse(enumerate(top_k))
                    if sum_elf > value
                        insert!(top_k, index + 1, sum_elf)
                        popfirst!(top_k)
                        break
                    end
                end
            end
            single_elf_calories = Vector{Int}(undef, 0)
        else
            push!(single_elf_calories, parse(Int, process_string))
        end
    end
    # top_k[K] holds the most calories
    return (top_k[K], sum(top_k))
end

println(part1and2())
