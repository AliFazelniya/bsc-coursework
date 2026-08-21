"""Domain objects and invariants for the game board."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Iterator, Literal, TypeAlias


Mark: TypeAlias = Literal["X", "O"]
Cell: TypeAlias = Mark | None
Move: TypeAlias = tuple[int, int]


@dataclass
class Board:
    """A square board whose cells contain an optional player mark."""

    size: int
    cells: list[list[Cell]] = field(init=False)

    def __post_init__(self) -> None:
        """Validate the size and initialise an empty board."""
        if not 3 <= self.size <= 10:
            raise ValueError("Board size must be between 3 and 10.")
        self.cells = [[None for _ in range(self.size)] for _ in range(self.size)]

    def clone(self) -> Board:
        """Return an independent copy of this board."""
        copied_board = Board(self.size)
        copied_board.cells = [row.copy() for row in self.cells]
        return copied_board

    def is_empty(self, move: Move) -> bool:
        """Return whether *move* is an unoccupied, valid board position."""
        row, column = move
        return self.is_valid_move(move) and self.cells[row][column] is None

    def is_full(self) -> bool:
        """Return whether every board position has been occupied."""
        return not any(cell is None for row in self.cells for cell in row)

    def is_valid_move(self, move: Move) -> bool:
        """Return whether *move* is within the board bounds."""
        row, column = move
        return 0 <= row < self.size and 0 <= column < self.size

    def legal_moves(self) -> list[Move]:
        """Return all unoccupied positions in row-major order."""
        return [
            (row, column)
            for row in range(self.size)
            for column in range(self.size)
            if self.cells[row][column] is None
        ]

    def place(self, move: Move, mark: Mark) -> None:
        """Place *mark* at *move* or raise ``ValueError`` when it is occupied."""
        if not self.is_empty(move):
            raise ValueError(f"Move {move} is outside the board or already occupied.")
        row, column = move
        self.cells[row][column] = mark

    def remove(self, move: Move) -> None:
        """Clear a move, primarily for use while exploring minimax branches."""
        if not self.is_valid_move(move):
            raise ValueError(f"Move {move} is outside the board.")
        row, column = move
        self.cells[row][column] = None

    def lines(self) -> Iterator[list[Cell]]:
        """Yield every row, column, and diagonal containing at least 3 cells."""
        yield from self.cells
        for column in range(self.size):
            yield [self.cells[row][column] for row in range(self.size)]
        yield from self._diagonals(1)
        yield from self._diagonals(-1)

    def state_key(self) -> str:
        """Return a compact, deterministic representation suitable for caching."""
        return "".join(cell or "_" for row in self.cells for cell in row)

    def _diagonals(self, column_step: int) -> Iterator[list[Cell]]:
        """Yield diagonals travelling down-right or down-left as requested."""
        starts = [(0, column) for column in range(self.size)]
        starts.extend(
            (row, 0 if column_step == 1 else self.size - 1)
            for row in range(1, self.size)
        )
        for start_row, start_column in starts:
            diagonal: list[Cell] = []
            row, column = start_row, start_column
            while 0 <= row < self.size and 0 <= column < self.size:
                diagonal.append(self.cells[row][column])
                row += 1
                column += column_step
            if len(diagonal) >= 3:
                yield diagonal
