# Numerical Root-Finding Toolkit (Interactive Notebook)

This project is an interactive, notebook-driven toolkit for solving **scalar nonlinear equations** of the form `f(x) = 0` and comparing the performance of classic numerical methods. It guides the user through defining a function and interval, computes iterative sequences for several methods, and offers an analysis mode with quantitative comparisons and plots.

The core focus is educational and comparative: it shows how different root-finding algorithms behave, how quickly they converge, and how Aitken's Δ² acceleration can improve convergence.

## Features

- **Interactive function input** using SymPy (symbol + expression parsing).
- **Interval validation** for bracketing methods (requires a sign change on `[a, b]`).
- **Step 1: fixed-iteration mode** with early stopping for convergence.
- **Step 2: convergence-based mode** using a relative error criterion.
- **Multiple algorithms** implemented and compared:
  - Bisection
  - Newton
  - Secant (with multiple initializations)
  - Simple Iteration (fixed-point iteration with user-suggested `g(x)`)
  - Aitken acceleration on each method's sequence
- **Analysis workflows** (Part 1 and Part 2) with optional plots and summary statistics.

## Repository Structure

- `main.ipynb` — primary notebook interface; orchestrates input, method execution, and analysis.
- `method/` — numerical method implementations:
  - `bisection.py`
  - `newton.py`
  - `secant.py`
  - `simpleiteration.py`
  - `aitken.py`
- `analysis/` — analysis and visualization utilities:
  - `choice1.py` — analysis of Step 1 results
  - `choice2.py` — analysis of Step 2 results

## How It Works

### 1) Input and Validation
The notebook asks for:
- The **symbol** used in the equation (e.g., `x`).
- The **function** `f(x)` as a SymPy expression.
- An interval `[a, b]` such that `f(a) * f(b) < 0`.

This ensures a valid bracketing interval for methods that require it.

### 2) Step 1 — Fixed Iterations + Early Stop
All methods are executed with a maximum of 10 iterations, but will stop early if:
```
|X_{i+1} - X_i| < 10^-9
```
This produces sequences of approximate roots for each method and a stop reason.

### 3) Step 2 — Convergence-Based Iterations
The same methods are executed again, this time using a relative convergence criterion:
```
|X_{k+1} - X_k| / |X_{k+1}| < 10^-6
```
This mode emphasizes speed-to-convergence rather than fixed iteration counts.

### 4) Aitken Acceleration
Aitken's Δ² process is applied to each method's sequence to produce accelerated sequences, allowing a direct comparison of improvement.

### 5) Analysis & Visualization
The analysis workflows compare:
- Final answers across methods
- Pairwise differences between methods
- Errors relative to a known root (optional)
- Iteration counts (speed)

Plots are generated using Matplotlib and Seaborn for visual comparison.

## Usage

Open and run the notebook:

```
main.ipynb
```

Follow the interactive prompts. The notebook will:
1. Ask for your symbol and function.
2. Request a valid interval `[a, b]`.
3. Compute Step 1 and Step 2 sequences.
4. Offer analysis and plotting options.

## Notes on Simple Iteration (`g(x)`)

The simple iteration method needs a fixed-point form `x = g(x)`. The implementation:
- Generates two default candidates: `x + f(x)` and `x - f(x)`.
- Asks the user for three additional candidate `g(x)` functions.
- Validates candidates for interval mapping and convergence (|g'(x)| < 1 at key points).
- Selects the best candidate based on convergence behavior.

## Dependencies

- Python 3.12
- `sympy`
- `pandas`
- `matplotlib`
- `seaborn`

Install as needed with your preferred environment manager.

## What This Project Is Best For

- Learning and comparing root-finding methods side-by-side
- Understanding convergence behavior and stopping criteria
- Demonstrating acceleration via Aitken's Δ² process
- Teaching numerical analysis concepts with interactive experimentation

## Limitations

- Designed for **single-variable** equations only.
- Fully interactive; not currently optimized for batch or automated runs.
- Some methods depend on valid user choices for convergence (e.g., `g(x)` selection).

## Acknowledgments

This notebook was designed to help analyze and compare classic numerical methods for finding roots. Feedback and improvements are welcome.
