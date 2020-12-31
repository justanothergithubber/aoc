"""Solves day 4 puzzle from Advent of Code 2020."""
from typing import List, Dict, Any
from re import search
from get_data import get_day_input


def parse_data(input_data) -> List[Dict[Any, Any]]:
    """Create the passport list from input data."""
    passport_list: List[Dict[Any, Any]] = [{}]
    passport_count = 0
    for line in input_data:
        if line == "":
            passport_list.append({})
            passport_count += 1
        else:
            ls_ = line.split()
            for kv_pair in ls_:
                key, val = kv_pair.split(":")
                if key in ("byr", "iyr", "eyr"):
                    val = int(val)
                elif key == "hgt":
                    try:
                        val = (int(val[:-2]), val[-2:])
                    except ValueError:
                        val = (val, "")
                passport_list[passport_count][key] = val
    return passport_list


def validate_passport(input_passport) -> int:
    """Validate data."""
    hair_re = r"^#(?:[0-9a-fA-F]{3}){1,2}$"
    valid_ecl = ("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
    id_re = r"^\d{9}$"
    try:
        # aliasing for < 80 char
        cm_check = (input_passport["hgt"][1] == "cm" and
                    150 <= input_passport["hgt"][0] <= 193)
        in_check = (input_passport["hgt"][1] == "in" and
                    59 <= input_passport["hgt"][0] <= 76)
        if all((1920 <= input_passport["byr"] <= 2002,
                2010 <= input_passport["iyr"] <= 2020,
                2020 <= input_passport["eyr"] <= 2030,
                (cm_check or in_check),
                search(hair_re, input_passport["hcl"]),
                input_passport["ecl"] in valid_ecl,
                search(id_re, input_passport["pid"])
                )
               ):
            return 1
    except KeyError:
        pass
    # else
    return 0


def part_one(input_passports) -> None:
    """Print part one answer."""
    necessary_fields = ("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")
    has_necessary_fields = 0
    for passport in input_passports:
        if all(field in passport for field in necessary_fields):
            has_necessary_fields += 1
    print(f"Part one ans: {has_necessary_fields}")


def part_two(input_passports) -> None:
    """Print part two answer."""
    valid_pass = 0
    for passport in input_passports:
        valid_pass += validate_passport(passport)
    print(f"Part two ans: {valid_pass}")


if __name__ == "__main__":
    dat = get_day_input(4)
    passports = parse_data(dat)
    part_one(passports)
    part_two(passports)
