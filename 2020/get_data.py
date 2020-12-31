"""Simple data helper function."""
from pathlib import Path
from requests import get

data_folder = Path("./inputs")


def get_day_input(day):
    """
    Retrieves data for specified day.

    Assumes that cookie file exists.
    """
    input_file = f"day{day}_input"
    data_folder.mkdir(exist_ok=True)
    input_file_path = data_folder / input_file
    if input_file_path.is_file():
        print("input exists locally, reusing")
    else:
        print("input not found locally, downloading")
        with open("cookie") as cookie_file:
            cookies = {"session": cookie_file.read()}
        input_get = get(f"https://adventofcode.com/2020/day/{day}/input",
                        cookies=cookies)
        with open(input_file_path, "w") as input_file_object:
            input_file_object.write(input_get.text)
    return open(input_file_path, 'r').read().split('\n')[:-1]
