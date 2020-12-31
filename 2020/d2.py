"""Solves day 2 puzzle from Advent of Code 2020."""
from typing import List
from collections import namedtuple
from get_data import get_day_input

PwdTuple = namedtuple("pwd_tuple", ('first', 'second', 'letter', 'password'))


def parse_data(input_data) -> List[PwdTuple]:
    """Create a list of password policies along with the passwords."""
    parsed_data = []
    for line in input_data:
        line_split = line.split()
        bounds = line_split[0].split('-')
        first, second = (int(bounds[0]), int(bounds[1]))
        letter = line_split[1][0]
        pwd = line_split[2]
        parsed_data.append(PwdTuple(first, second, letter, pwd))
    return parsed_data


def part_one(input_data) -> None:
    """Print part one answer."""
    valid_pass = 0
    for pwd_data in input_data:
        if (pwd_data.first <= pwd_data.password.count(pwd_data.letter)
                <= pwd_data.second):
            valid_pass += 1
    print(f"Part one ans: {valid_pass}")


def part_two(input_data) -> None:
    """Print part two answer."""
    valid_pass = 0
    for pwd_data in input_data:
        valid = (
                    (pwd_data.password[pwd_data.first - 1] ==
                     pwd_data.letter and
                     pwd_data.password[pwd_data.second - 1] !=
                     pwd_data.letter
                     ) or
                    (pwd_data.password[pwd_data.first - 1] !=
                     pwd_data.letter and
                     pwd_data.password[pwd_data.second - 1] ==
                     pwd_data.letter
                     )
                 )
        if valid:
            valid_pass += 1
    print(f"Part two ans: {valid_pass}")


if __name__ == "__main__":
    dat = get_day_input(2)
    dat = parse_data(dat)
    part_one(dat)
    part_two(dat)
