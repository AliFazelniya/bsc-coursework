# Linear System Methods

## Overview
This folder contains the solver implementations used by the notebook. The emphasis is on clarity and algorithmic structure rather than calling high-level library solvers.

## Methods Included
Direct methods:
- `cramer.py`: Cramer’s Rule solver.
- `gaussianelimination.py`: Gauss-Jordan style elimination.
- `doolittle.py`: LU decomposition (Doolittle) and solve.
- `choleskydecomposition.py`: Cholesky factorization and solve.
- `croutdecomposition.py`: LU decomposition (Crout) and solve.

Iterative methods:
- `jacobi.py`: Jacobi iteration with configurable norm stopping.
- `gaussseidel.py`: Gauss-Seidel iteration with configurable norm stopping.
- `sor.py`: Successive Over-Relaxation (SOR) iteration with relaxation factor `w`.

## How It Is Used
- Each method is imported by `main.ipynb` and executed against the same system.
- Iterative methods rely on `norm_handler` in `matrix/funcs.py` for stopping criteria.

## Notes
- Cholesky requires a symmetric positive definite matrix; otherwise it returns a failure message.
- Crout stops if a zero pivot is encountered.
- Cramer’s Rule requires `det(A) != 0` and is expensive for large systems.
