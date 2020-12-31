"""Solves day 8 puzzle from Advent of Code 2020."""
from typing import List, Tuple, Set
from get_data import get_day_input


InstType = List[Tuple[int, int]]
INSTRUCTIONS = {
    "nop": 0,
    "acc": 1,
    "jmp": 2
}
SWITCH = {
    0: 2,  # NOP -> JMP
    2: 0   # JMP -> NOP
}


def get_instruction_list(input_data: List[str]) -> List[Tuple[int, int]]:
    """Get the instruction list from input of strings."""
    out_list = []
    for line in input_data:
        ls_ = line.split()
        out_list.append((INSTRUCTIONS[ls_[0]], int(ls_[1])))
    return out_list


def do_instruction(current_position: int,
                   accumulator_value: int,
                   instruction: int,
                   instruction_value: int) -> Tuple[int, int]:
    """Perform instruction."""
    if instruction == 0:
        current_position += 1
    elif instruction == 1:
        accumulator_value += instruction_value
        current_position += 1
    elif instruction == 2:
        current_position += instruction_value
    return (current_position, accumulator_value)


def naive_part_one_ans(input_instruction_list: InstType) -> int:
    """Get the answer to part one in a naive implementation."""
    len_list = len(input_instruction_list)
    seen = {0}
    acc_val = 0
    cur_pos = 0
    prev = 0
    instructions_done = 0
    while instructions_done < len_list:  # better guarantee of termination
        instr = input_instruction_list[cur_pos]
        cur_pos, acc_val = do_instruction(cur_pos, acc_val, instr[0], instr[1])
        if cur_pos in seen:
            break
        prev = acc_val
        seen.add(cur_pos)
    return prev


# In essence part one has 'best' algorithm involving O(n) time and O(1)
# memory with use of Floyd's cycle detection algorithm, then traversing
# the cycle once. Memory can be kept to O(1) in the whole process through
# streaming the file input rather than reading the whole file into memory


# Part 2 we classify all nodes into cyclic and terminating sets
# Then we check iteratively
# Implicitly assumes instruction indexed at len(instruction) is
# TERMINATING node - other possibilities include negatives or just
# any other number not within 0 to (len(instruction) - 1)


def classify_all_nodes(input_instruction_list: InstType) -> Set[int]:
    """Classify all instructions to either cyclic or terminating."""
    cyclic: Set[int] = set()
    terminating: Set[int] = set()
    len_list = len(input_instruction_list)
    for (start_pos, instruction) in enumerate(input_instruction_list):
        if start_pos in cyclic or start_pos in terminating:
            continue
        cur_set = {start_pos}
        cur_pos, acc_val = (start_pos, 0)
        instructions_done = 0
        while instructions_done < len_list:
            cur_pos, acc_val = do_instruction(cur_pos, acc_val,
                                              instruction[0], instruction[1])
            if cur_pos in cur_set:
                cyclic = cyclic | cur_set
                break
            if cur_pos < len_list:
                instruction = input_instruction_list[cur_pos]
            else:
                terminating = terminating | cur_set
                break
            cur_set.add(cur_pos)
            instructions_done += 1
    return terminating


def check_and_run(input_instruction_list: InstType) -> int:
    """Check through instruction list and finally run modified."""
    term = classify_all_nodes(input_instruction_list)
    len_list = len(input_instruction_list)
    cur_pos, _ = 0, 0
    instructions_done = 0
    while instructions_done < len_list:
        instr = input_instruction_list[cur_pos]
        if instr[0] == 0 or instr[0] == 2:
            chk_pos, _ = do_instruction(cur_pos, _,
                                        SWITCH[instr[0]], instr[1])
            if chk_pos in term:
                input_instruction_list[cur_pos] = (SWITCH[instr[0]], instr[1])
                break
        cur_pos, _ = do_instruction(cur_pos, _,
                                    instr[0], instr[1])
        instructions_done += 1
    cur_pos, acc_val = 0, 0
    instructions_done = 0
    while instructions_done < len_list:
        if cur_pos >= len_list:
            break
        instr = input_instruction_list[cur_pos]
        cur_pos, acc_val = do_instruction(cur_pos, acc_val,
                                          instr[0], instr[1])
        instructions_done += 1
    return acc_val


def part_one(input_instruction_list: InstType) -> None:
    """Prints part one's answer'"""
    print(f"Part one ans: {naive_part_one_ans(input_instruction_list)}")


def part_two(input_instruction_list: InstType) -> None:
    """Prints part two's answer'"""
    print(f"Part two ans: {check_and_run(input_instruction_list)}")


if __name__ == "__main__":
    dat = get_day_input(8)
    instrs = get_instruction_list(dat)
    part_one(instrs)
    part_two(instrs)
