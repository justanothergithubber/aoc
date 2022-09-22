include("day_setup.jl")  # puts DAY_DATA into namespace

Vent = Tuple{Int,Int,Int,Int}

function read_line_to_vent(input_line::AbstractString)::Vent
    return Tuple(
        (parse.(Int, reduce(vcat, split.(split(input_line, " -> "), ','))))
    ) .+ 1  # Because Julia uses 1-indexing
end

const ALL_VENTS::Vector{Vent} = read_line_to_vent.(DAY_DATA)
const COORDINATE_MAX::Int = maximum(maximum(ALL_VENTS))

function part1and2()::NTuple{2,Int}
    xy_vent_map::Matrix{Int} = zeros(COORDINATE_MAX, COORDINATE_MAX)
    diag_vent_map::Matrix{Int} = zeros(COORDINATE_MAX, COORDINATE_MAX)
    for vent in ALL_VENTS
        if vent[1] == vent[3]
            vent_y_min, vent_y_max = minmax(vent[2], vent[4])
            xy_vent_map[vent[1], vent_y_min:vent_y_max] .+= 1
        elseif vent[2] == vent[4]
            vent_x_min, vent_x_max = minmax(vent[1], vent[3])
            xy_vent_map[vent_x_min:vent_x_max, vent[2]] .+= 1
        elseif allequal(abs.(vent[3:4] .- vent[1:2]))
            vent_difference = only(unique(abs.(vent[3:4] .- vent[1:2])))
            lower_vent, upper_vent = extrema((vent[1:2], vent[3:4]))
            x_step = 2 * (upper_vent[1] > lower_vent[1]) - 1
            y_step = 2 * (upper_vent[2] > lower_vent[2]) - 1
            for step in 0:vent_difference
                diag_vent_map[
                    lower_vent[1]+step*x_step,
                    lower_vent[2]+step*y_step
                ] += 1
            end
        elseif (vent[1] == vent[4]) || (vent[2] == vent[3])
            vent_difference = abs(only(unique(vent[[1, 4]] .- vent[[2, 3]])))
            lower_coordinate, upper_coordinate = minmax(vent[1:2])
            for step in 0:vent_difference
                diag_vent_map[
                    lower_coordinate+step,
                    upper_coordinate-step
                ] += 1
            end
        end
    end
    return (
        count.(>=(2), (xy_vent_map, xy_vent_map .+ diag_vent_map))
    )
end

println(part1and2())
