"""Pygame views and input handling for the game."""

from __future__ import annotations

import sys
from dataclasses import dataclass, field

import pygame

from .domain import Board, Move
from .scoring import Score


WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (220, 45, 45)
BLUE = (35, 105, 215)


def prompt_board_size() -> int:
    """Open a dialog and return a board size selected by the player."""
    pygame.init()
    screen = pygame.display.set_mode((400, 200))
    pygame.display.set_caption("Board Size")
    title_font = pygame.font.Font(None, 40)
    note_font = pygame.font.Font(None, 25)
    input_box = pygame.Rect(100, 80, 200, 40)
    active = False
    text = ""

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                _quit_application()
            if event.type == pygame.MOUSEBUTTONDOWN:
                active = input_box.collidepoint(event.pos)
            if event.type == pygame.KEYDOWN and active:
                if event.key == pygame.K_RETURN:
                    if text.isdigit() and 3 <= int(text) <= 10:
                        pygame.quit()
                        return int(text)
                    text = ""
                elif event.key == pygame.K_BACKSPACE:
                    text = text[:-1]
                elif event.unicode.isdigit():
                    text += event.unicode

        border_color = BLUE if active else BLACK
        screen.fill(WHITE)
        pygame.draw.rect(screen, border_color, input_box, 2, border_radius=10)
        screen.blit(title_font.render("Enter board size", True, BLACK), (80, 30))
        text_position = input_box.x + 85, input_box.y + 7
        screen.blit(title_font.render(text, True, BLACK), text_position)
        note = "Note: board size must be between 3 and 10."
        screen.blit(note_font.render(note, True, BLACK), (35, 150))
        pygame.display.flip()


@dataclass
class GameView:
    """Render the board and translate mouse clicks into board positions."""

    board: Board
    cell_size: int = field(init=False)
    screen_size: int = field(init=False)
    screen: pygame.Surface = field(init=False)

    def __post_init__(self) -> None:
        """Create the game window and configure dimensions for this board."""
        pygame.init()
        self.cell_size = 60 if self.board.size > 6 else 100
        self.screen_size = self.board.size * self.cell_size
        self.screen = pygame.display.set_mode((self.screen_size, self.screen_size))
        pygame.display.set_caption("Neicharan's Dooz")

    def clicked_move(self, position: tuple[int, int]) -> Move | None:
        """Convert a pixel position to a valid board move, if it is on the board."""
        x_position, y_position = position
        move = y_position // self.cell_size, x_position // self.cell_size
        return move if self.board.is_valid_move(move) else None

    def draw(self) -> None:
        """Draw the current board state."""
        self.screen.fill(WHITE)
        for index in range(self.board.size + 1):
            offset = index * self.cell_size
            pygame.draw.line(
                self.screen, BLACK, (0, offset), (self.screen_size, offset), 2
            )
            pygame.draw.line(
                self.screen, BLACK, (offset, 0), (offset, self.screen_size), 2
            )
        for row in range(self.board.size):
            for column in range(self.board.size):
                mark = self.board.cells[row][column]
                if mark == "X":
                    self._draw_x(row, column)
                elif mark == "O":
                    self._draw_o(row, column)
        pygame.display.flip()

    def _draw_x(self, row: int, column: int) -> None:
        """Draw a human mark in the selected cell."""
        padding = max(10, self.cell_size // 5)
        left = column * self.cell_size + padding
        top = row * self.cell_size + padding
        right = (column + 1) * self.cell_size - padding
        bottom = (row + 1) * self.cell_size - padding
        pygame.draw.line(self.screen, RED, (left, top), (right, bottom), 4)
        pygame.draw.line(self.screen, RED, (left, bottom), (right, top), 4)

    def _draw_o(self, row: int, column: int) -> None:
        """Draw a computer mark in the selected cell."""
        center = (
            column * self.cell_size + self.cell_size // 2,
            row * self.cell_size + self.cell_size // 2,
        )
        pygame.draw.circle(self.screen, BLUE, center, self.cell_size // 2 - 20, 4)


def show_result(score: Score, board: Board) -> None:
    """Display final scores until the player presses a key or closes the window."""
    width = max(500, 350 + board.size * 50)
    height = max(250, board.size * 50 + 50)
    screen = pygame.display.set_mode((width, height))
    pygame.display.set_caption("Game Over")
    title_font = pygame.font.Font(None, 60)
    score_font = pygame.font.Font(None, 40)
    note_font = pygame.font.Font(None, 30)
    winner = score.winner
    if winner is None:
        message = "Draw!"
    elif winner == "X":
        message = "You won!"
    else:
        message = "Computer won!"

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                _quit_application()
            if event.type == pygame.KEYDOWN:
                pygame.quit()
                return
        screen.fill(WHITE)
        screen.blit(title_font.render(message, True, BLACK), (20, 20))
        human_score = score_font.render(f"Your points: {score.human}", True, BLUE)
        computer_score = score_font.render(
            f"Computer points: {score.computer}", True, RED
        )
        exit_note = note_font.render("Press any key to exit", True, BLACK)
        screen.blit(human_score, (20, 100))
        screen.blit(computer_score, (20, 150))
        screen.blit(exit_note, (20, height - 40))
        _draw_final_board(screen, board, 350, 50)
        pygame.display.flip()


def _draw_final_board(
    screen: pygame.Surface,
    board: Board,
    start_x: int,
    start_y: int,
) -> None:
    """Draw a compact representation of *board* in the results view."""
    cell_size = 50
    for row in range(board.size):
        for column in range(board.size):
            left = start_x + column * cell_size
            top = start_y + row * cell_size
            rectangle = pygame.Rect(left, top, cell_size, cell_size)
            pygame.draw.rect(screen, BLACK, rectangle, 2)
            mark = board.cells[row][column]
            if mark == "X":
                pygame.draw.line(
                    screen, BLUE, rectangle.topleft, rectangle.bottomright, 3
                )
                pygame.draw.line(
                    screen, BLUE, rectangle.bottomleft, rectangle.topright, 3
                )
            elif mark == "O":
                pygame.draw.circle(screen, RED, rectangle.center, cell_size // 3, 3)


def _quit_application() -> None:
    """Close pygame cleanly and terminate the interactive program."""
    pygame.quit()
    sys.exit()
