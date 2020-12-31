"""Solves day 1 puzzle of Advent of Code 2020."""
from get_data import get_day_input


def part_one(input_data) -> None:
    """Computes answer to part one."""
    to_look_for = []
    for next_input in input_data:
        if next_input in to_look_for:
            print(f"Part one ans: {next_input * (2020 - next_input)}")
            break
        to_look_for.append(2020 - next_input)


def part_two(input_data) -> None:
    """Computes answer to part two."""
    to_look_for = []
    candidates = []
    for i in input_data:
        for j in input_data[1:]:
            if i + j < 2020:
                to_look_for.append(2020 - i - j)
        if i in to_look_for:
            candidates.append(i)
            if len(candidates) == 2:
                p2ans = (candidates[0] *
                         candidates[1] * (2020 -
                                          candidates[0] -
                                          candidates[1]
                                          )
                         )
                print(f"Part two ans: {p2ans}")
                break


if __name__ == "__main__":
    dat = [int(x) for x in get_day_input(1)]
    part_one(dat)
    part_two(dat)
