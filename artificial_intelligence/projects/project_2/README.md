# AI Numerical Puzzle Solver (CSP)

Project Overview

> This project implements an advanced **Constraint Satisfaction Problem (CSP)** solver built purely in Python. The goal is to process an $N /times M$ grid of numbers and systematically eliminate specific cells (replacing them with `0`) so that the remaining numbers in each row and column sum exactly to a predefined set of targets.

## Modular Architecture

The project has been refactored into a clean, maintainable Object-Oriented structure:

- `main.py`: The entry point of the application.
- `gui.py`: Contains the Tkinter GUI class for visualization and interactions.
- `csp_solver.py`: The core algorithmic engine (Backtracking + Domain Reduction).
- `file_io.py`: Handles error-resistant parsing of `.txt` grid configurations.

## How to Run

> [!warning] Prerequisites
> The project runs entirely on standard library modules. **No external dependencies** (like NumPy or Pandas) are required. You only need a standard Python 3.x environment.

1. Ensure all Python files and your `puzzle.txt` are in the same directory.
2. Run the application via terminal:

   ```bash
   python main.py
   ```

   Click Load Puzzle in the GUI, select your text file, and click Solve.

## CSP Methodology

The CSPSolver class avoids brute-force checking by employing two crucial Consistency Checks (Domain Reduction) to aggressively prune the search tree:

Overflow Check: Rejects a path immediately if keeping the current cell's value exceeds the target row/column sum.
Underflow Check: Uses dynamic rem_row_sums and rem_col_sums. It rejects a path if dropping the current value makes it mathematically impossible to reach the target with the remaining numbers.
Extra Challenges Implemented

1. Graphical User Interface (GUI)
   A responsive Dark-Themed GUI built with tkinter allows users to select puzzles dynamically without hardcoding file paths.

2. Non-Square Grid Support
   The solver dynamically adapts to $R /times C$ matrices (e.g., $3 /times 5$). Just provide Rows,Cols on the first line of the .txt file instead of a single integer $N$.

3. Step-by-Step Animation
   The backtracking process is visually animated in real-time.

🟡 Yellow: Forward checking.
🔴 Red: Dead-end reached; triggering backtrack.
🟢 Green: Final valid solution path.

4. Unique Numbers Constraint
   Users can toggle a strict uniqueness constraint via the GUI. When enabled, the algorithm enforces that no duplicate numbers can exist within the same row or column of the final solution (Sudoku-style constraint).
