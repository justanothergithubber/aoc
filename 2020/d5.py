"""Solves day 5 puzzle from Advent of Code 2020."""
from typing import Tuple
from get_data import get_day_input


def to_binary(input_str: str, mode=0):
    """Get either row or column of seat from binary string."""
    if mode == 0:
        exp = 7
        lower_letter = "F"
    else:
        exp = 3
        lower_letter = "L"
    low, upp = (0, (2**exp)-1)
    exp -= 1
    for idx, letter in enumerate(input_str):
        shift = exp-idx
        if letter == lower_letter:
            upp -= 2**(shift)
        else:  # letter is increaser
            low += 2**(shift)
    return low


def get_seat_position(input_str: str):
    """Get exact seat position."""
    return(to_binary(input_str[:7]), to_binary(input_str[7:], mode=1))


def get_seat_id(input_seat_position: Tuple[int, int]):
    """Get seat id."""
    return input_seat_position[0] * 8 + input_seat_position[1]


def part_one(input_data) -> int:
    """Print part one answer."""
    part_one_ans = max(map(get_seat_id, map(get_seat_position, input_data)))
    print(f"Part one ans: {part_one_ans}")
    return part_one_ans  # used in part 2


def part_two(part_one_ans: int, input_data) -> None:
    """Print part two answer."""
    seen = set()
    for seat_str in input_data:
        seat_pos = get_seat_position(seat_str)
        seat_id = get_seat_id(seat_pos)
        seen.add(seat_id)
    candidates = set(range(part_one_ans)) - seen
    for candidate in candidates:
        if (candidate + 1 in seen and candidate - 1 in seen):
            part_two_ans = candidate
    print(f"Part two ans: {part_two_ans}")


if __name__ == "__main__":
    dat = get_day_input(5)
    p1 = part_one(dat)
    part_two(p1, dat)
