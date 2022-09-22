include("day_setup.jl")  # puts DAY_DATA into namespace

const DAY_DATA_BIT::BitMatrix = mapreduce(
    permutedims, vcat, [parse.(Bool, split(x, "")) for x in DAY_DATA]
)
const NUM_LINES::Int = length(DAY_DATA)
const LEN_LINES::Int = length(DAY_DATA[1])
const FILTER_FUNC::Dict{Bool,Function} = Dict(true => identity, false => .!)

function part1()::Int
    threshold = NUM_LINES ÷ 2
    gamma_rate_vec = vec(sum(DAY_DATA_BIT, dims=1) .>= threshold)
    epsilon_rate_vec = .!gamma_rate_vec
    gamma_rate = evalpoly(2, reverse(gamma_rate_vec))
    epsilon_rate = evalpoly(2, reverse(epsilon_rate_vec))
    return gamma_rate * epsilon_rate
end

function filter_candidates(
    input_matrix::BitMatrix, input_index::Int; o2orco2::Bool=true
)::BitMatrix
    num_vecs::Int = size(input_matrix)[1]
    if num_vecs > 1
        one_or_zero_filter = FILTER_FUNC[
            o2orco2==(sum(input_matrix[:, input_index])>=num_vecs÷2)
        ]
        input_matrix = input_matrix[
            one_or_zero_filter(input_matrix[:, input_index]), :]
    end
    return input_matrix
end

function part2()::Int
    o2_candidates = copy(DAY_DATA_BIT)
    co2_candidates = copy(DAY_DATA_BIT)
    for index::Int in 1:LEN_LINES
        o2_candidates = filter_candidates(o2_candidates, index)
        co2_candidates = filter_candidates(
            co2_candidates, index; o2orco2=false
        )
    end
    o2_gen_rating = evalpoly(2, reverse(vec(o2_candidates)))
    co2_scrubber_rating = evalpoly(2, reverse(vec(co2_candidates)))
    return o2_gen_rating * co2_scrubber_rating
end

println(part1())
println(part2())
