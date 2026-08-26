import os

def read_puzzle(file_path="puzzle.txt"):
    """
    Reads the puzzle information from a text file.
    
    Args:
        file_path (str): The path to the input puzzle file.
        
    Returns:
        tuple: (n, row_targets, col_targets, grid)
    """
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File '{file_path}' not found. Please ensure the file is in the correct directory.")

    with open(file_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # Remove trailing whitespaces and empty lines
    lines = [line.strip() for line in lines if line.strip()]

    # Extract the first line: grid size (N)
    n = int(lines[0])

    # Extract the second line: row targets
    row_targets = [int(x) for x in lines[1].split(',')]

    # Extract the third line: column targets
    col_targets = [int(x) for x in lines[2].split(',')]

    # Extract the numbers grid
    grid = []
    for i in range(3, 3 + n):
        row = [int(x) for x in lines[i].split(',')]
        grid.append(row)

    # Validation checks to ensure the file format is consistent
    assert len(row_targets) == n, "Number of row targets does not match grid size N."
    assert len(col_targets) == n, "Number of column targets does not match grid size N."
    assert len(grid) == n, "Number of grid rows does not match grid size N."

    return n, row_targets, col_targets, grid


def write_solution(grid, file_path="solution.txt"):
    """
    Writes the solved grid to an output file.
    
    Args:
        grid (list of lists): The solved N x N matrix.
        file_path (str): The path to the output text file.
    """
    with open(file_path, 'w', encoding='utf-8') as file:
        for row in grid:
            # Convert numbers to strings and join them with commas
            row_str = ",".join(map(str, row))
            file.write(row_str + "\n")
            
    print(f"✅ Solution successfully saved to '{file_path}'.")