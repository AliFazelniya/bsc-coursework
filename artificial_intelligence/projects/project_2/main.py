import os
import time
import tkinter as tk
from tkinter import filedialog, messagebox

# ==========================================
# 1. File I/O Operations (Updated for Non-Square)
# ==========================================

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

# ==========================================
# 2. CSP Solver (Updated for Uniqueness & Step-by-Step)
# ==========================================

class CSPSolver:
    def __init__(self, rows, cols, row_targets, col_targets, initial_grid, unique_constraint=False, step_callback=None):
        self.rows = rows
        self.cols = cols
        self.row_targets = row_targets
        self.col_targets = col_targets
        self.initial_grid = initial_grid
        self.unique_constraint = unique_constraint
        self.step_callback = step_callback
        
        self.current_grid = [[0 for _ in range(cols)] for _ in range(rows)]
        self.row_sums = [0] * rows
        self.col_sums = [0] * cols
        
        self.rem_row_sums = [sum(row) for row in initial_grid]
        self.rem_col_sums = [sum(initial_grid[i][j] for i in range(rows)) for j in range(cols)]

    def solve(self):
        if self._backtrack(0, 0):
            return self.current_grid
        return None

    def _backtrack(self, row, col):
        # Update GUI if callback is provided
        if self.step_callback:
            self.step_callback(self.current_grid, row, col)

        if row == self.rows:
            return self._is_solved()
            
        next_row = row if col < self.cols - 1 else row + 1
        next_col = col + 1 if col < self.cols - 1 else 0
        
        val = self.initial_grid[row][col]
        self.rem_row_sums[row] -= val
        self.rem_col_sums[col] -= val
        
        # --- Branch 1: Keep Value ---
        can_keep = (self.row_sums[row] + val <= self.row_targets[row]) and \
                   (self.col_sums[col] + val <= self.col_targets[col])
                   
        # Check Uniqueness Constraint (Extra Challenge)
        if can_keep and self.unique_constraint:
            in_row = val in self.current_grid[row]
            in_col = any(self.current_grid[i][col] == val for i in range(self.rows))
            if in_row or in_col:
                can_keep = False

        if can_keep:
            self.current_grid[row][col] = val
            self.row_sums[row] += val
            self.col_sums[col] += val
            
            if self._backtrack(next_row, next_col):
                return True
                
            self.row_sums[row] -= val
            self.col_sums[col] -= val
            self.current_grid[row][col] = 0

        # --- Branch 2: Remove Value (Set to 0) ---
        can_remove = (self.row_sums[row] + self.rem_row_sums[row] >= self.row_targets[row]) and \
                     (self.col_sums[col] + self.rem_col_sums[col] >= self.col_targets[col])
                     
        if can_remove:
            if self._backtrack(next_row, next_col):
                return True

        self.rem_row_sums[row] += val
        self.rem_col_sums[col] += val
        
        # Update GUI to show backtracking
        if self.step_callback:
            self.step_callback(self.current_grid, row, col, backtracking=True)
            
        return False

    def _is_solved(self):
        for i in range(self.rows):
            if self.row_sums[i] != self.row_targets[i]: return False
        for j in range(self.cols):
            if self.col_sums[j] != self.col_targets[j]: return False
        return True


# ==========================================
# 3. Graphical User Interface (GUI)
# ==========================================

class PuzzleGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("AI CSP Puzzle Solver")
        self.root.configure(bg="#2E3440")
        
        self.grid_cells = []
        self.rows = 0
        self.cols = 0
        self.puzzle_data = None
        
        # Controls Frame
        ctrl_frame = tk.Frame(root, bg="#3B4252", pady=10)
        ctrl_frame.pack(fill=tk.X)
        
        self.btn_load = tk.Button(ctrl_frame, text="Load Puzzle", command=self.load_file, bg="#81A1C1", fg="white", font=("Arial", 10, "bold"))
        self.btn_load.pack(side=tk.LEFT, padx=10)
        
        self.btn_solve = tk.Button(ctrl_frame, text="Solve (Step-by-Step)", command=self.start_solving, state=tk.DISABLED, bg="#A3BE8C", fg="white", font=("Arial", 10, "bold"))
        self.btn_solve.pack(side=tk.LEFT, padx=10)
        
        self.unique_var = tk.BooleanVar()
        self.chk_unique = tk.Checkbutton(ctrl_frame, text="Unique Numbers Constraint", variable=self.unique_var, bg="#3B4252", fg="white", selectcolor="#2E3440")
        self.chk_unique.pack(side=tk.LEFT, padx=10)

        # Grid Frame
        self.grid_frame = tk.Frame(root, bg="#2E3440", padx=20, pady=20)
        self.grid_frame.pack()

    def load_file(self):
        script_dir = os.path.dirname(os.path.abspath(__file__))
        filepath = filedialog.askopenfilename(initialdir=script_dir, title="Select Puzzle File", filetypes=(("Text files", "*.txt"), ("All files", "*.*")))
        if not filepath: return
        
        try:
            self.rows, self.cols, row_t, col_t, grid = read_puzzle(filepath)
            self.puzzle_data = (self.rows, self.cols, row_t, col_t, grid)
            self.draw_grid(grid)
            self.btn_solve.config(state=tk.NORMAL)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to load file:\n{e}")

    def draw_grid(self, grid):
        for widget in self.grid_frame.winfo_children():
            widget.destroy()
            
        self.grid_cells = [[None for _ in range(self.cols)] for _ in range(self.rows)]
        
        for r in range(self.rows):
            for c in range(self.cols):
                val = grid[r][c]
                lbl = tk.Label(self.grid_frame, text=str(val), width=4, height=2, font=("Helvetica", 14, "bold"), bg="#D8DEE9", fg="#2E3440", relief="raised")
                lbl.grid(row=r, column=c, padx=2, pady=2)
                self.grid_cells[r][c] = lbl

    def update_cell(self, grid, current_r, current_c, backtracking=False):
        for r in range(self.rows):
            for c in range(self.cols):
                val = grid[r][c]
                lbl = self.grid_cells[r][c]
                
                if val == 0:
                    lbl.config(text="", bg="#4C566A") # Zero/Removed
                else:
                    lbl.config(text=str(val), bg="#E5E9F0", fg="#2E3440") # Kept value
                    
                # Highlight the current cell being processed
                if r == current_r and c == current_c:
                    lbl.config(bg="#BF616A" if backtracking else "#EBCB8B", fg="white")
                    
        self.root.update()
        time.sleep(0.02) # SPEED OF ANIMATION: adjust this value to make it faster/slower

    def start_solving(self):
        self.btn_solve.config(state=tk.DISABLED)
        self.btn_load.config(state=tk.DISABLED)
        
        rows, cols, row_t, col_t, init_grid = self.puzzle_data
        solver = CSPSolver(rows, cols, row_t, col_t, init_grid, 
                           unique_constraint=self.unique_var.get(), 
                           step_callback=self.update_cell)
        
        start_time = time.time()
        solution = solver.solve()
        end_time = time.time()
        
        if solution:
            # Final green highlight for success
            self.update_cell(solution, -1, -1)
            for r in range(self.rows):
                for c in range(self.cols):
                    if solution[r][c] != 0:
                        self.grid_cells[r][c].config(bg="#A3BE8C", fg="#2E3440")
                        
            # Save output
            script_dir = os.path.dirname(os.path.abspath(__file__))
            write_solution(solution, os.path.join(script_dir, "solution.txt"))
            messagebox.showinfo("Success", f"Solved in {end_time - start_time:.3f} seconds!\nSaved to solution.txt")
        else:
            messagebox.showwarning("Failed", "No solution exists for these constraints.")
            
        self.btn_solve.config(state=tk.NORMAL)
        self.btn_load.config(state=tk.NORMAL)

if __name__ == "__main__":
    root = tk.Tk()
    app = PuzzleGUI(root)
    root.mainloop()