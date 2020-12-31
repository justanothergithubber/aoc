"""Solves day 6 puzzle from Advent of Code 2020."""
from typing import List, Set
from get_data import get_day_input


def get_group_sizes(input_data: List[str], part_two_flag=False) -> List[int]:
    """Get the group sizes."""
    groups: List[Set[str]] = [set()]
    start_flag = True
    for line in input_data:
        if line == "":
            groups.append(set())
            start_flag = True
        if part_two_flag:
            if all((groups[-1] == set(), set(line) != set(), start_flag)):
                groups[-1] = set(line)
                start_flag = False
            else:
                groups[-1] = groups[-1] & set(line)
                if groups[-1] == set():
                    continue
        else:
            groups[-1] = groups[-1] | set(line)
            if len(groups[-1]) == 26:
                continue
    group_sizes = [len(group) for group in groups]
    return group_sizes


def part_one(input_data) -> None:
    """Print part one answer."""
    print(f"Part one ans: {sum(get_group_sizes(input_data))}")


def part_two(input_data) -> None:
    """Print part two answer."""
    gr_sizes = get_group_sizes(input_data, part_two_flag=True)
    print(f"Part two ans: {sum(gr_sizes)}")


if __name__ == "__main__":
    dat = get_day_input(6)
    part_one(dat)
    part_two(dat)
