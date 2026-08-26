import os

def read_puzzle(file_path):
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File '{file_path}' not found.")

    with open(file_path, 'r', encoding='utf-8') as file:
        lines = [line.strip() for line in file.readlines() if line.strip()]

    # Handle square (N) or non-square (Rows,Cols) grids
    dimensions = lines[0].split(',')
    if len(dimensions) == 2:
        rows, cols = int(dimensions[0]), int(dimensions[1])
    else:
        rows = cols = int(dimensions[0])

    row_targets = [int(x) for x in lines[1].split(',')]
    col_targets = [int(x) for x in lines[2].split(',')]

    grid = []
    for i in range(3, 3 + rows):
        row = [int(x) for x in lines[i].split(',')]
        grid.append(row)

    assert len(row_targets) == rows, "Row targets count mismatch."
    assert len(col_targets) == cols, "Column targets count mismatch."
    assert len(grid) == rows and all(len(r) == cols for r in grid), "Grid dimensions mismatch."

    return rows, cols, row_targets, col_targets, grid


def write_solution(grid, file_path="solution.txt"):
    with open(file_path, 'w', encoding='utf-8') as file:
        for row in grid:
            file.write(",".join(map(str, row)) + "\n")