"""Solves day 3 puzzle from Advent of Code 2020."""
from typing import Tuple, List
from math import prod
from functools import partial
from get_data import get_day_input


def count_trees(input_slope: Tuple[int, int], input_data: List[str]) -> int:
    """Count the number of trees along the slope"""
    (x_coord, y_coord) = (0, 0)
    x_travel, y_travel = input_slope
    trees = 0
    while y_coord < map_height:
        x_coord = (x_coord + x_travel) % map_width
        y_coord += y_travel
        if input_data[y_coord][x_coord] == "#":
            trees += 1
    return trees


def part_one(input_slope_list, input_data) -> None:
    """Print part one answer."""
    print(f"Part one ans: {count_trees(input_slope_list[1], input_data)}")


def part_two(input_slope_list, input_data) -> None:
    """Print part two answer."""
    tree_fixed_data = partial(count_trees, input_data=input_data)
    print(f"Part two ans: {prod(map(tree_fixed_data, input_slope_list))}")


if __name__ == "__main__":
    dat = get_day_input(3)
    slope_list = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    map_width = len(dat[0])
    map_height = len(dat) - 1  # 0-based indexing
    part_one(slope_list, dat)
    part_two(slope_list, dat)
