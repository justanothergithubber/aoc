"""Simple data helper function."""
from pathlib import Path
from urllib.request import Request, urlopen

data_folder = Path("./inputs")


def get_day_input(day):
    """
    Retrieves data for specified day.

    Assumes that cookie file exists.
    """
    input_file = f"day{day}_input"
    day_url = f"https://adventofcode.com/2020/day/{day}/input"
    data_folder.mkdir(exist_ok=True)
    input_file_path = data_folder / input_file
    if input_file_path.is_file():
        print("input exists locally, reusing")
    else:
        print("input not found locally, downloading")
        with open("cookie") as cookie_file:
            cookie = cookie_file.read()
        req = Request(day_url, headers={"Cookie": f"session={cookie}"})
        with urlopen(req) as response:
            the_page = response.read()
            with open(input_file_path, "wb") as input_file_object:
                input_file_object.write(the_page)
    return open(input_file_path, "r").read().split("\n")[:-1]
