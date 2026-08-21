"""Scoring rules for Neicharan's Dooz."""

from dataclasses import dataclass
from typing import Iterable

from .domain import Board, Cell, Mark


@dataclass(frozen=True)
class Score:
    """The accumulated scores for the human and computer players."""

    human: int
    computer: int

    @property
    def winner(self) -> Mark | None:
        """Return the leading mark, or ``None`` when the scores are tied."""
        if self.human > self.computer:
            return "X"
        if self.computer > self.human:
            return "O"
        return None


def score_board(board: Board) -> Score:
    """Calculate total scores from every row, column, and eligible diagonal."""
    human_score = 0
    computer_score = 0
    for line in board.lines():
        human_score += score_line(line, "X")
        computer_score += score_line(line, "O")
    return Score(human=human_score, computer=computer_score)


def score_line(line: Iterable[Cell], mark: Mark) -> int:
    """Return points for consecutive runs of *mark* in a line."""
    score = 0
    run_length = 0
    for cell in line:
        if cell == mark:
            run_length += 1
            continue
        score += _run_score(run_length)
        run_length = 0
    return score + _run_score(run_length)


def evaluate(board: Board) -> int:
    """Return a minimax utility: positive values favour the computer."""
    result = score_board(board)
    return (result.computer > result.human) - (result.human > result.computer)


def _run_score(run_length: int) -> int:
    """Return the score assigned to one consecutive run."""
    return 2 * run_length - 5 if run_length >= 3 else 0
