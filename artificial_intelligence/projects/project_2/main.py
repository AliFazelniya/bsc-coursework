import os
import time

# ==========================================
# File I/O Operations
# ==========================================

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

# ==========================================
# CSP Solver Implementation
# ==========================================

class CSPSolver:
    """
    A Constraint Satisfaction Problem (CSP) solver for the numerical puzzle.
    Uses backtracking with domain reduction and consistency checks.
    """
    def __init__(self, n, row_targets, col_targets, initial_grid):
        self.n = n
        self.row_targets = row_targets
        self.col_targets = col_targets
        self.initial_grid = initial_grid
        
        # The grid that will store our solution (0s or original values)
        self.current_grid = [[0 for _ in range(n)] for _ in range(n)]
        
        # --- Optimization States ---
        # Track the current sums of rows and columns during backtracking
        self.row_sums = [0] * n
        self.col_sums = [0] * n
        
        # Track the maximum possible sum remaining for each row and column.
        # Initially, it is the sum of all elements in that row/column.
        self.rem_row_sums = [sum(row) for row in initial_grid]
        self.rem_col_sums = [sum(initial_grid[i][j] for i in range(n)) for j in range(n)]

    def solve(self):
        """
        Initiates the backtracking process starting from the top-left cell (0, 0).
        
        Returns:
            list of lists: The solved grid if a solution exists, else None.
        """
        if self._backtrack(0, 0):
            return self.current_grid
        return None

    def _backtrack(self, row, col):
        """
        Recursive backtracking function that explores possibilities cell by cell.
        
        Args:
            row (int): Current row index.
            col (int): Current column index.
            
        Returns:
            bool: True if a valid configuration is found, False otherwise.
        """
        # Base Case: If we have moved past the last row, the grid is fully processed.
        if row == self.n:
            return self._is_solved()
            
        # Calculate the coordinates of the next cell
        next_row = row if col < self.n - 1 else row + 1
        next_col = col + 1 if col < self.n - 1 else 0
        
        # The original value of the current cell
        val = self.initial_grid[row][col]
        
        # Domain Reduction Step 1: 
        # We are at this cell, so its value is no longer "remaining" in our future choices.
        self.rem_row_sums[row] -= val
        self.rem_col_sums[col] -= val
        
        # ---------------------------------------------------------
        # Branch 1: Try keeping the original value (Assignment: val)
        # ---------------------------------------------------------
        # Consistency Check (Overflow): Adding this value must not exceed the target.
        can_keep = (self.row_sums[row] + val <= self.row_targets[row]) and \
                   (self.col_sums[col] + val <= self.col_targets[col])
                   
        if can_keep:
            # Apply the choice
            self.current_grid[row][col] = val
            self.row_sums[row] += val
            self.col_sums[col] += val
            
            # Move to the next cell recursively
            if self._backtrack(next_row, next_col):
                return True
                
            # Undo the choice (Backtrack)
            self.row_sums[row] -= val
            self.col_sums[col] -= val
            self.current_grid[row][col] = 0

        # ---------------------------------------------------------
        # Branch 2: Try removing the value (Assignment: 0)
        # ---------------------------------------------------------
        # Consistency Check (Underflow): Even if we drop this value, can we still 
        # reach the target using the remaining available numbers in this row/col?
        can_remove = (self.row_sums[row] + self.rem_row_sums[row] >= self.row_targets[row]) and \
                     (self.col_sums[col] + self.rem_col_sums[col] >= self.col_targets[col])
                     
        if can_remove:
            # Note: We don't need to update current_grid or sums because the value is 0
            if self._backtrack(next_row, next_col):
                return True

        # Backtrack Step: Restore the remaining sums before returning to the previous cell
        self.rem_row_sums[row] += val
        self.rem_col_sums[col] += val
        
        return False

    def _is_solved(self):
        """
        Final verification to ensure all row and column targets are met exactly.
        
        Returns:
            bool: True if all targets are perfectly matched, False otherwise.
        """
        for i in range(self.n):
            if self.row_sums[i] != self.row_targets[i] or self.col_sums[i] != self.col_targets[i]:
                return False
        return True


# ==========================================
# Main Execution Block
# ==========================================

if __name__ == "__main__":
    print("--- Starting CSP Puzzle Solver ---")
    
    # 1. Read input data
    input_filename = "puzzle.txt"
    try:
        n, row_targets, col_targets, grid = read_puzzle(input_filename)
        print(f"Loaded puzzle of size {n}x{n} from '{input_filename}'.")
    except Exception as e:
        print(f"Error loading file: {e}")
        exit(1)

    # 2. Initialize Solver and measure execution time
    start_time = time.time()
    solver = CSPSolver(n, row_targets, col_targets, grid)
    
    print("Solving... (Applying Backtracking with Consistency Checks)")
    solution = solver.solve()
    end_time = time.time()
    
    # 3. Handle results
    if solution:
        print(f"Puzzle solved successfully in {end_time - start_time:.4f} seconds.")
        # Write to solution.txt
        write_solution(solution, "solution.txt")
    else:
        print("No solution exists for the given puzzle constraints.")