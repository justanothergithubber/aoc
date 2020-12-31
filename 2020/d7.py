"""Solves day 7 puzzle from Advent of Code 2020."""
from typing import (List, Tuple, Set, Dict,
                    Union, SupportsInt, Optional)
from get_data import get_day_input


GraphType = Dict[str, List[Tuple[str, int]]]


def make_forward_backward(input_data: List[str]) -> Tuple[GraphType,
                                                          GraphType]:
    """Create the forward and backward graph representations."""
    output_forward_graph: GraphType = {}
    output_backward_graph: GraphType = {}
    for line in input_data:
        line_split = line.split("bags contain")
        container = line_split[0].strip()
        contained = line_split[1][:-1].strip()
        output_forward_graph[container] = []
        if "no other bags" in contained:
            pass
        else:
            all_contained_bags = contained.split(",")
            for contained_bag_with_amount in all_contained_bags:
                amount: Union[SupportsInt, str]  # pylint: disable=E1136
                amount, colour = contained_bag_with_amount.strip(
                                 ).split(" ", 1)
                amount = int(amount)
                colour = colour[:colour.find("bag")].strip()
                if colour not in output_backward_graph:
                    output_backward_graph[colour] = []
                output_forward_graph[container].append((colour, amount))
                output_backward_graph[colour].append((container, amount))
    return (output_forward_graph, output_backward_graph)


def get_all_ancestors(input_backward_graph: GraphType,
                      ancestor_set: Set[str],
                      colour: str) -> Optional[bool]:  # pylint: disable=E1136
    """Add ancestors to a set"""
    if colour in ancestor_set:
        return False
    # else
    ancestor_set.add(colour)
    for containing_bag in input_backward_graph[colour]:
        colour_to_check = containing_bag[0]
        if colour_to_check in input_backward_graph:
            get_all_ancestors(input_backward_graph,
                              ancestor_set, colour_to_check)
        else:
            ancestor_set.add(colour_to_check)
    return True


def get_gold_set(input_backward_graph: GraphType) -> Set[str]:
    """Get the set of coloured bags that can contain shiny gold."""
    output_gold_set: Set[str] = set()
    for bag_and_amount in input_backward_graph["shiny gold"]:
        colour = bag_and_amount[0]
        get_all_ancestors(input_backward_graph, output_gold_set, colour)
    return output_gold_set


def count_all_bags(input_forward_graph: GraphType,
                   bag_count_so_far: Dict[str, int],
                   input_bag_type: str,
                   ) -> int:
    """Count all bags that can possibly be contained by a shiny gold bag."""
    if input_bag_type in bag_count_so_far:
        return bag_count_so_far[input_bag_type]
    if input_bag_type not in input_forward_graph:
        bag_count_so_far[input_bag_type] = 0
        return 0

    amount = 0
    for bag in input_forward_graph[input_bag_type]:
        bag_type, bag_amount = bag
        amount += bag_amount * (count_all_bags(input_forward_graph,
                                               bag_count_so_far,
                                               bag_type,
                                               ) + 1)
    return amount


def part_one(input_backward_graph) -> None:
    """Prints part one's answer'"""
    gold_set = get_gold_set(input_backward_graph)
    print(f"Part one ans: {len(gold_set)}")


def part_two(input_forward_graph) -> None:
    """Prints part two's answer'"""
    count_of_bags = count_all_bags(input_forward_graph, {}, 'shiny gold')
    print(f"Part two ans: {count_of_bags}")


if __name__ == "__main__":
    dat = get_day_input(7)
    forward_graph, backward_graph = make_forward_backward(dat)
    part_one(backward_graph)
    part_two(forward_graph)
