module GetData
export get_day_data
using Downloads: download

const INPUTS_FOLDER::String = "inputs"
const SESSION_COOKIE::String = read("cookie", String)

# Create directory as required
if !isdir(INPUTS_FOLDER)
    mkdir(INPUTS_FOLDER)
end

function get_day_data(day_number::Int)::Vector{String}
    day_num_str::String = string(day_number)
    day_input_file::String = INPUTS_FOLDER * "/day_" * lpad(day_num_str, 2, "0") * "_input.txt"
    # Only download if file does not exist locally
    if !isfile(day_input_file)
        download(
            "https://adventofcode.com/2021/day/" * day_num_str * "/input",
            day_input_file;
            headers=Dict(["Cookie" => "session=" * SESSION_COOKIE])
        )
    end
    return readlines(day_input_file)
end

end
