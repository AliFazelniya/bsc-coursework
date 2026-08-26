import tkinter as tk
from gui import PuzzleGUI

if __name__ == "__main__":
    print("Starting AI CSP Puzzle Solver (Modular Version)...")
    root = tk.Tk()
    app = PuzzleGUI(root)
    root.mainloop()