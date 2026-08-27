import os
import time
import tkinter as tk
from tkinter import filedialog, messagebox

# Importing our custom modules
from file_io import read_puzzle, write_solution
from csp_solver import CSPSolver

class PuzzleGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("AI CSP Puzzle Solver")
        self.root.configure(bg="#2E3440")
        
        self.grid_cells = []
        self.rows = 0
        self.cols = 0
        self.puzzle_data = None
        
        ctrl_frame = tk.Frame(root, bg="#3B4252", pady=10)
        ctrl_frame.pack(fill=tk.X)
        
        self.btn_load = tk.Button(ctrl_frame, text="Load Puzzle", command=self.load_file, bg="#81A1C1", fg="white", font=("Arial", 10, "bold"))
        self.btn_load.pack(side=tk.LEFT, padx=10)
        
        self.btn_solve = tk.Button(ctrl_frame, text="Solve (Step-by-Step)", command=self.start_solving, state=tk.DISABLED, bg="#A3BE8C", fg="white", font=("Arial", 10, "bold"))
        self.btn_solve.pack(side=tk.LEFT, padx=10)
        
        self.unique_var = tk.BooleanVar()
        self.chk_unique = tk.Checkbutton(ctrl_frame, text="Unique Numbers Constraint", variable=self.unique_var, bg="#3B4252", fg="white", selectcolor="#2E3440")
        self.chk_unique.pack(side=tk.LEFT, padx=10)

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
            messagebox.showerror("Error", f"Failed to load file:/n{e}")

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
                    lbl.config(text="", bg="#4C566A") 
                else:
                    lbl.config(text=str(val), bg="#E5E9F0", fg="#2E3440") 
                    
                if r == current_r and c == current_c:
                    lbl.config(bg="#BF616A" if backtracking else "#EBCB8B", fg="white")
                    
        self.root.update()
        time.sleep(0.02)

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
            self.update_cell(solution, -1, -1)
            for r in range(self.rows):
                for c in range(self.cols):
                    if solution[r][c] != 0:
                        self.grid_cells[r][c].config(bg="#A3BE8C", fg="#2E3440")
                        
            script_dir = os.path.dirname(os.path.abspath(__file__))
            write_solution(solution, os.path.join(script_dir, "solution.txt"))
            messagebox.showinfo("Success", f"Solved in {end_time - start_time:.3f} seconds!/nSaved to solution.txt")
        else:
            messagebox.showwarning("Failed", "No solution exists for these constraints.")
            
        self.btn_solve.config(state=tk.NORMAL)
        self.btn_load.config(state=tk.NORMAL)