include("day_setup.jl")  # puts DAY_DATA into namespace

const m::Int = length(DAY_DATA)
const n::Int = length(DAY_DATA[1])

function convert_data_to_matrix(input_data::Vector{String})
    data_matrix = Matrix{Int}(undef, m, n)
    for (i, str) in enumerate(input_data)
        for (j, data) in enumerate(str)
            data_matrix[i, j] = parse(Int, data)
        end
    end
    return data_matrix
end

const DAY_DATA_MATRIX::Matrix{Int} = convert_data_to_matrix(DAY_DATA)

function part1()::Int
    visible = fill(0, m, n)
    visblility_vector = fill(-Inf, n)
    for (row_idx, row) in enumerate(eachrow(DAY_DATA_MATRIX))
        visible[row_idx, :] =
            max.(visblility_vector .< row, visible[row_idx, :])
        visblility_vector = (max.(visblility_vector, row))
    end
    visblility_vector = fill(-Inf, n)
    for (rev_idx, row) in
        enumerate(Iterators.reverse(eachrow(DAY_DATA_MATRIX)))
        row_idx = m - rev_idx + 1
        visible[row_idx, :] =
            max.(visblility_vector .< row, visible[row_idx, :])
        visblility_vector = (max.(visblility_vector, row))
    end
    visblility_vector = fill(-Inf, m)
    for (col_idx, col) in enumerate(eachcol(DAY_DATA_MATRIX))
        visible[:, col_idx] =
            max.(visblility_vector .< col, visible[:, col_idx])
        visblility_vector = (max.(visblility_vector, col))
    end
    visblility_vector = fill(-Inf, m)
    for (rev_idx, col) in
        enumerate(Iterators.reverse(eachcol(DAY_DATA_MATRIX)))
        col_idx = m - rev_idx + 1
        visible[:, col_idx] =
            max.(visblility_vector .< col, visible[:, col_idx])
        visblility_vector = (max.(visblility_vector, col))
    end
    return sum(visible)
end

println(part1())
