# Prolog-Puzzle-Solver
AI Assignment 2

This project involves implementing Prolog code to solve two types of puzzles using search algorithms. 

## Question 1: Uninformed Search for Color Cycles

In this question, you are required to implement a Prolog code that uses uninformed search (breadth-first or depth-first) to solve the following puzzle or indicate that there is no solution.

### Problem Statement

You are given a board that consists of N x M cells. Each cell contains a color (Red, Yellow, or Blue). Your task is to find color cycles for any of the three colors.

For example, as shown in the picture, cells `2,1 -> 2,2 -> 3,2 -> 3,1` form a blue cycle. Another cycle could be cells `2,0 -> 2,1 -> 3,1 -> 3,0`. Note that yellow and red colors do not form cycles in this example. 

Your code should print at least one of these cycles including its color (if any) or indicate that no cycles exist.

### Cycle Definition

A cycle defined by the following cells `c1, c2, ..., ck` must have the following:
- These cells are different (no duplicates)
- At least 4 cells (or more)
- All cells have the same color
- The cells are adjacent to each other

### Requirements

You are allowed to use the search engine for uninformed search given in the lab. Your main tasks are:
- **Design Input:** Define how the board will be represented in Prolog.
- **Design State Representation:** Define how each state will be represented.
- **Design Moves:** Define how to move from one cell to another.
- **Design Output:** Define how the results (cycles or no cycles) will be printed.

## Question 2: Informed Search for Path Finding

In this question, you are required to implement a Prolog code that uses informed search (A*) to solve the following puzzle or indicate that there is no solution.

### Problem Statement

You are given a board that consists of N x M cells. Each cell contains a color (Red, Yellow, or Blue). You will be given a start and goal cell of the same color. Your task is to find if there is a path between the start and the end cells. All cells on the path must be of the same color.

For example, as shown in the picture, `0,0` is the start cell and `1,3` is the end cell. The correct path is `0,0 -> 1,0 -> 2,0 -> 2,1 -> 2,2 -> 1,2 -> 1,3`.

### Path Definition

- Diagonal moves are not allowed. You can move left, right, up, and down.
- The path must not contain repeated cells.

### Requirements

You are allowed to use the search engine for informed search given in the lab, but ensure it uses A*. Your main tasks are:
- **Design Input:** Define how the board will be represented in Prolog.
- **Design State Representation:** Define how each state will be represented.
- **Design Moves:** Define how to move from one cell to another.
- **Design Heuristic Predicate:** Define the heuristic function to estimate the cost from the current cell to the goal.
- **Design Output:** Define how the results (paths or no paths) will be printed.


# Contributors
* [Ahmed Abd El-Wahab](https://github.com/AliveTube)
* [Mohamed Khaled (Amin)](https://github.com/emailam)
* [Alan Samir](https://github.com/alanhakoun)
* [Mohamed Essam](https://github.com/MohamedEssam71)
