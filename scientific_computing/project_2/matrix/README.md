# Matrix Utilities

## Overview
This folder contains shared linear algebra helpers used by the solvers and the notebook. The functions here implement core matrix operations and convergence checks without relying on high-level black-box routines, so the behavior is explicit and easy to inspect.

## Contents
- Determinant calculation (custom 3x3 shortcut, otherwise NumPy).
- Gauss-Jordan style reduction for inverse computation.
- Upper and lower triangular conversions.
- Matrix inverse via augmented matrix and row reduction.
- Spectral radius computation.
- Norm-based stopping tests for iterative methods.
- Diagonal dominance checks (row and column).
- Iteration matrix construction for Jacobi and Gauss-Seidel.
- Manual matrix transpose helper.

## Key File
- `matrix/funcs.py`: All matrix helpers and norm utilities.

## How It Is Used
- All solver implementations import functions from `matrix/funcs.py`.
- The notebook uses these helpers for diagnostics and analysis tables.

## Notes
- `norm_handler` uses a default tolerance of `1e-6`.
- Some routines perform minimal pivoting; if a pivot is zero, the function may raise or return early.
