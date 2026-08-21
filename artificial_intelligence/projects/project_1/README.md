# Neicharan's Dooz

A Pygame implementation of the scored tic-tac-toe variant **Neicharan's Dooz**.
The human plays `X`; a depth-limited minimax agent with alpha-beta pruning plays
`O`. Runs of three or more consecutive marks score points in rows, columns, and
both diagonal directions.

## Project layout

```text
.
├── src/
│   └── neicharans_dooz/
│       ├── app.py                # Application flow
│       ├── ai.py                 # Minimax computer opponent
│       ├── domain.py             # Board and game types
│       ├── gui.py                # Pygame input and rendering
│       └── scoring.py            # Scoring rules
├── tests/                        # Automated unit tests
├── main.py                       # Backward-compatible launcher
└── pyproject.toml                # Dependencies and tool configuration
```

This `src` layout separates application code from tests, documentation, and
runtime data. It scales cleanly as new game modes, views, or AI strategies are
added.

## Installation and use

Use Python 3.10 or newer. Install the project in editable mode:

```bash
python3 -m pip install -e .
```

Start the game with either command:

```bash
python3 main.py
neicharans-dooz
```

## Quality checks

The project uses PEP 8-compatible formatting, complete docstrings, and strict
type checking configuration. Run the checks with:

```bash
python3 -m unittest discover -s tests
ruff check .
black --check .
mypy src
```
