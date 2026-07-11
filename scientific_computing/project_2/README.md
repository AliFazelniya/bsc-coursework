# Linear System Solver (Direct + Iterative Methods)

## Overview
This project solves a system of linear equations using multiple direct and iterative numerical methods. The workflow is implemented in an interactive Jupyter notebook that:

- Accepts a user-defined linear system in symbolic form.
- Converts it into matrix form `A x = b`.
- Solves the system using several algorithms.
- Compares results, convergence behavior, and numerical differences.
- Provides diagnostic tables and plots for analysis.

The implementation avoids relying on high-level black-box solvers and instead demonstrates the underlying algorithms directly.

## Methods Implemented
Direct methods:
- Cramer’s Rule
- Gaussian Elimination (Gauss-Jordan style)
- LU Decomposition (Doolittle)
- Cholesky Decomposition
- LU Decomposition (Crout)

Iterative methods:
- Jacobi (with 1-norm, 2-norm, and infinity-norm stopping tests)
- Gauss-Seidel (with 1-norm, 2-norm, and infinity-norm stopping tests)
- SOR (Successive Over-Relaxation) with user-defined `w`

## What the Notebook Does
`main.ipynb` drives the entire workflow. It:

1. Prompts for the number of equations and variables (must match).
2. Prompts for the variable symbol (e.g., `x`) to build `x1, x2, ...`.
3. Reads each equation as a string and parses it into a symbolic form.
4. Converts the system into numeric matrices `A` and `b`.
5. Builds an initial guess `x0` for iterative methods.
6. Runs all solvers and stores their results.
7. Prints formatted tables of solutions and iterative sequences.
8. Computes matrix diagnostics (rank, determinant, symmetry, diagonal dominance, etc.).
9. Compares direct methods and iterative methods using L-infinity norms.
10. Plots pairwise differences between final iterative solutions.

The notebook includes explanatory markdown above every code cell to document its purpose and logic.

## Repository Structure
- `main.ipynb`: Interactive notebook that orchestrates input, solving, and analysis.
- `method/`: Algorithm implementations.
- `matrix/funcs.py`: Shared matrix utilities (determinant, inverse, triangular conversion, spectral radius, norms, etc.).

## How to Run
1. Open `main.ipynb` in Jupyter or VS Code.
2. Run cells from top to bottom.
3. Provide inputs when prompted:
   - Number of equations
   - Number of variables (must match)
   - Variable symbol (e.g., `x`)
   - SOR relaxation factor `w`
   - Maximum number of iterations `k`
   - Each equation in the form `ax1 + bx2 + ... = c`

Example input (3 equations):
```text
3x1 + 5x2 - 10x3 = 18
2x1 - 7x2 + 10x3 = -15
4x1 + x2 - 3x3 = 2
```

## Convergence and Diagnostics
The notebook computes and reports:

- Diagonal dominance checks (row/column).
- Spectral radius of Jacobi and Gauss-Seidel iteration matrices.
- Simple convergence heuristics based on these properties.
- Full iteration tables and final solutions for each norm.

Stopping criteria for iterative methods are implemented in `matrix/funcs.py` using a default tolerance of `1e-6`.

## Notes and Limitations
- Cholesky requires a symmetric positive definite matrix; otherwise it is skipped.
- Crout decomposition stops if a zero pivot is encountered.
- Cramer’s Rule is only valid when `det(A) != 0`.
- Large systems may be slow with Cramer’s Rule due to determinant computation.

## Dependencies
- Python 3
- `numpy`
- `sympy`
- `tabulate`
- `matplotlib`

Install dependencies as needed in your environment.

## Intended Use
This project is suitable for learning and comparing linear system solvers, understanding convergence behavior of iterative methods, and inspecting matrix properties that affect stability and convergence.
