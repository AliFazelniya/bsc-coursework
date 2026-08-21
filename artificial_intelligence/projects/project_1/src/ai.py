"""Minimax computer opponent with alpha-beta pruning."""

from __future__ import annotations

from dataclasses import dataclass, field
from math import inf

from .domain import Board, Move
from .scoring import evaluate


@dataclass
class MinimaxAgent:
    """Choose computer moves using depth-limited minimax search.

    The depth cap keeps the graphical application responsive on large boards.
    Completed search nodes are cached for the duration of one computer turn.
    """

    maximum_depth: int = 5
    _cache: dict[tuple[str, bool, int], tuple[int, Move | None]] = field(
        default_factory=dict,
        init=False,
    )

    def choose_move(self, board: Board) -> Move | None:
        """Return the best legal computer move, or ``None`` on a full board."""
        if board.is_full():
            return None
        self._cache.clear()
        depth = min(self.maximum_depth, board.size + 3, len(board.legal_moves()))
        _, move = self._minimax(board, depth, True, -inf, inf)
        return move

    def _minimax(
        self,
        board: Board,
        depth: int,
        maximizing: bool,
        alpha: float,
        beta: float,
    ) -> tuple[int, Move | None]:
        """Evaluate a search node and return its utility and best move."""
        if depth == 0 or board.is_full():
            return evaluate(board), None

        cache_key = (board.state_key(), maximizing, depth)
        cached_result = self._cache.get(cache_key)
        if cached_result is not None:
            return cached_result

        mark = "O" if maximizing else "X"
        best_value = -inf if maximizing else inf
        best_move: Move | None = None
        fully_explored = True

        for move in board.legal_moves():
            board.place(move, mark)
            value, _ = self._minimax(board, depth - 1, not maximizing, alpha, beta)
            board.remove(move)

            if (maximizing and value > best_value) or (
                not maximizing and value < best_value
            ):
                best_value, best_move = value, move

            if maximizing:
                alpha = max(alpha, value)
            else:
                beta = min(beta, value)
            if beta <= alpha:
                fully_explored = False
                break

        result = int(best_value), best_move
        if fully_explored:
            self._cache[cache_key] = result
        return result
