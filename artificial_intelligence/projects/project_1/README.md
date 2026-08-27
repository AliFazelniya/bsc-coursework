# Neicharan's Dooz

An advanced, generalized implementation of Tic-Tac-Toe (Dooz) with dynamic board sizes and a highly optimized Minimax AI opponent. Developed as a final project for Artificial Intelligence, this game features a modern Pygame GUI and advanced game-tree search algorithms.

## Features

- **Dynamic Board Sizes:** Play on any board size from `3x3` up to `10x10`.
- **Advanced AI Opponent:** Powered by the Minimax algorithm, capable of looking several moves ahead to block human strategies and build complex traps.
- **Modern GUI:** A sleek, Dark Mode interface built with Pygame, featuring an interactive setup menu, hover effects, and real-time score tracking.
- **CLI Logging:** Seamlessly logs every move to the terminal using standard grid coordinates (e.g., `a3`, `d2`) to strictly follow project requirements.
- **Full Board Play:** Unlike classic Tic-Tac-Toe, the game doesn't end after the first line. The game continues until the board is completely full, making it a strategic battle of territory.

## AI & Architecture

To prevent performance bottlenecks on large boards (like 10x10), the AI engine (`ai.py`) utilizes several state-of-the-art optimization techniques:

1. **Alpha-Beta Pruning:** Drastically reduces the number of nodes evaluated by the Minimax algorithm.
2. **Dynamic Depth Limiting:** Automatically adjusts the search depth based on the board size and the number of empty cells remaining.
3. **Move Ordering:** Evaluates the most promising moves first (closer to the center and adjacent to existing marks) to maximize Alpha-Beta cut-offs.
4. **Proximity Pruning:** On larger boards, the AI ignores completely isolated cells, narrowing its focus to the "combat zones" and allowing it to search deeper into the game tree.

## Scoring System

The game features a unique quadratic scoring system that rewards building longer continuous lines of marks (horizontal, vertical, or diagonal).

For any continuous line of length $n$ (where $n \ge 3$), the score is calculated using the following mathematical formula:

$$Score = (n - 2) + (n - 3)^2$$

**Examples:**

- **3 marks:** $(3 - 2) + (0)^2 = 1$ point
- **4 marks:** $(4 - 2) + (1)^2 = 3 points$
- **5 marks:** $(5 - 2) + (2)^2 = 7 points$
- **6 marks:** $(6 - 2) + (3)^2 = 13 points$

## Project Structure

The project follows a clean, object-oriented architecture (Separation of Concerns):

- `board.py`: Core domain model. Manages board state, move validation, and recursive line extraction/scoring.
- `ai.py`: The brain of the game. Contains the Minimax algorithm, heuristic evaluations, and move pruning logic.
- `gui.py`: The presentation layer. Handles Pygame rendering, user inputs, and interactive menus.
- `main.py`: The main controller loop that integrates the UI with the underlying game logic and AI.

## Installation & Usage

### Prerequisites

Make sure you have Python 3.x installed on your machine. You will also need the `pygame` library.

### Setup

1. Clone or download this repository.
2. Install the required dependencies:

```bash
pip install pygame
```

### Run the game

```bash
python main.py
```

### How to Play

1. Launch the game and select your preferred board size (3-10).

2. Choose your mark (X or O). Note: X always makes the first move.

3. Click on the grid to place your mark.

4. The game ends when all cells are filled. The player with the highest total score wins!
