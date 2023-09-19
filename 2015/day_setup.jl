include("get_data.jl")
using .GetData: get_day_data
if !(abspath(PROGRAM_FILE) == @__FILE__)
    const DAY_DATA::Vector{String} = get_day_data(
        parse(Int, filter.(isdigit, split(
            PROGRAM_FILE, Base.Filesystem.path_separator
        )[end]))
    )
end
