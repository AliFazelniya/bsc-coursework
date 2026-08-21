"""Application orchestration for Neicharan's Dooz."""

from __future__ import annotations

import sys

import pygame

from .ai import MinimaxAgent
from .domain import Board
from .gui import GameView, prompt_board_size, show_result
from .scoring import score_board


def main() -> None:
    """Run one interactive game from board-size selection through final score."""
    board = Board(prompt_board_size())
    view = GameView(board)
    agent = MinimaxAgent()

    while not board.is_full():
        view.draw()
        _handle_human_turn(board, view)
        if board.is_full():
            break
        computer_move = agent.choose_move(board)
        if computer_move is not None:
            board.place(computer_move, "O")

    show_result(score_board(board), board)


def _handle_human_turn(board: Board, view: GameView) -> None:
    """Process events until a valid human move is made or the app exits."""
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                move = view.clicked_move(event.pos)
                if move is not None and board.is_empty(move):
                    board.place(move, "X")
                    return
