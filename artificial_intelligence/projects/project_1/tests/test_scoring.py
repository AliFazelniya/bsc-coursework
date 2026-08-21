"""Unit tests for the game-domain and scoring rules."""

import unittest

from neicharans_dooz.ai import MinimaxAgent
from neicharans_dooz.domain import Board
from neicharans_dooz.scoring import score_board, score_line


class ScoringTests(unittest.TestCase):
    """Verify scores from runs and all board directions."""

    def test_three_mark_run_scores_one_point(self) -> None:
        """A three-cell run should use the documented scoring formula."""
        self.assertEqual(score_line(["X", "X", "X"], "X"), 1)

    def test_main_diagonal_is_scored(self) -> None:
        """A computer diagonal contributes to its total score."""
        board = Board(3)
        for index in range(3):
            board.place((index, index), "O")
        self.assertEqual(score_board(board).computer, 1)

    def test_board_rejects_occupied_move(self) -> None:
        """A cell cannot be assigned a second mark."""
        board = Board(3)
        board.place((0, 0), "X")
        with self.assertRaises(ValueError):
            board.place((0, 0), "O")

    def test_agent_returns_a_legal_move(self) -> None:
        """The minimax agent should select an available position."""
        board = Board(3)
        board.place((1, 1), "X")
        move = MinimaxAgent(maximum_depth=3).choose_move(board)
        self.assertIsNotNone(move)
        assert move is not None
        self.assertTrue(board.is_empty(move))


if __name__ == "__main__":
    unittest.main()
