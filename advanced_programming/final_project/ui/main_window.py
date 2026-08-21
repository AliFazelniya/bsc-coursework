"""Main dashboard window for Economy Manager."""

from __future__ import annotations

from typing import Sequence

from PyQt5 import QtCore, QtGui, QtWidgets

from core.config import get_settings
from database import get_user_name
from services.currency_service import CurrencyRate, CurrencyService
from ui.dialogs import LoginDialog, SignupDialog, TransactionDialog
from ui.plots import MonthlyPlotWindow
from ui.workers import CurrencyWorker


class MainWindow(QtWidgets.QMainWindow):
    """Present account actions, daily records, plots, and exchange rates."""

    def __init__(self) -> None:
        super().__init__()
        self._user_email: str | None = None
        self._currency_thread: QtCore.QThread | None = None
        self._currency_worker: CurrencyWorker | None = None
        self._income_plot: MonthlyPlotWindow | None = None
        self._expense_plot: MonthlyPlotWindow | None = None

        self.setWindowTitle("Economy Manager")
        icon_path = get_settings().assets_directory / "profit.png"
        self.setWindowIcon(QtGui.QIcon(str(icon_path)))
        self.resize(1100, 640)
        self._build_ui()
        self._refresh_currency_rates()

    def _build_ui(self) -> None:
        """Construct the dashboard widgets and actions."""
        central_widget = QtWidgets.QWidget(self)
        layout = QtWidgets.QGridLayout(central_widget)
        self.setCentralWidget(central_widget)

        self._calendar = QtWidgets.QCalendarWidget()
        self._calendar.setGridVisible(True)
        self._calendar.selectionChanged.connect(self._open_transaction_dialog)
        layout.addWidget(self._calendar, 0, 0, 2, 1)

        self._welcome_text = QtWidgets.QPlainTextEdit()
        self._welcome_text.setReadOnly(True)
        self._welcome_text.setPlainText(
            "Welcome to Economy Manager. Log in to record daily income and "
            "expenses, then view monthly trends."
        )
        layout.addWidget(self._welcome_text, 2, 0)

        self._income_button = QtWidgets.QPushButton("Show income plot")
        self._expense_button = QtWidgets.QPushButton("Show expense plot")
        self._income_button.clicked.connect(lambda: self._show_plot("income"))
        self._expense_button.clicked.connect(lambda: self._show_plot("expense"))
        self._set_account_controls_enabled(False)
        layout.addWidget(self._income_button, 3, 0)
        layout.addWidget(self._expense_button, 4, 0)

        self._rates_table = QtWidgets.QTableWidget(6, 2)
        self._rates_table.setHorizontalHeaderLabels(["Currency", "Price (Toman)"])
        self._rates_table.verticalHeader().setVisible(False)
        self._rates_table.setEditTriggers(QtWidgets.QAbstractItemView.NoEditTriggers)
        self._rates_table.horizontalHeader().setSectionResizeMode(
            QtWidgets.QHeaderView.Stretch
        )
        layout.addWidget(self._rates_table, 0, 1, 4, 1)

        self._clock = QtWidgets.QLCDNumber()
        layout.addWidget(self._clock, 4, 1)
        self._update_clock()
        self._clock_timer = QtCore.QTimer(self)
        self._clock_timer.timeout.connect(self._update_clock)
        self._clock_timer.start(1_000)

        self._status_label = QtWidgets.QLabel("Sign in to manage your records.")
        self.statusBar().addPermanentWidget(self._status_label)
        self._build_menu()

    def _build_menu(self) -> None:
        """Create the application menu bar."""
        account_menu = self.menuBar().addMenu("Account")
        login_action = account_menu.addAction("Log in")
        signup_action = account_menu.addAction("Sign up")
        refresh_action = self.menuBar().addAction("Refresh rates")
        login_action.triggered.connect(self._log_in)
        signup_action.triggered.connect(self._sign_up)
        refresh_action.triggered.connect(self._refresh_currency_rates)

    def _set_account_controls_enabled(self, enabled: bool) -> None:
        """Enable controls that require an authenticated user."""
        self._income_button.setEnabled(enabled)
        self._expense_button.setEnabled(enabled)

    def _update_clock(self) -> None:
        """Update the clock display."""
        self._clock.display(QtCore.QTime.currentTime().toString("hh:mm:ss"))

    def _log_in(self) -> None:
        """Open the login dialog and establish the dashboard session."""
        dialog = LoginDialog(self)
        if dialog.exec_() != QtWidgets.QDialog.Accepted or dialog.email is None:
            return
        self._user_email = dialog.email
        username = get_user_name(dialog.email) or dialog.email
        self._status_label.setText(f"Logged in as {username}")
        self._set_account_controls_enabled(True)

    def _sign_up(self) -> None:
        """Open the account creation dialog."""
        SignupDialog(self).exec_()

    def _open_transaction_dialog(self) -> None:
        """Prompt for a selected day's income and expense values."""
        if self._user_email is None:
            self.statusBar().showMessage("Log in before recording transactions.", 4_000)
            return
        record_date = self._calendar.selectedDate().toPyDate()
        dialog = TransactionDialog(record_date, self)
        if dialog.exec_() == QtWidgets.QDialog.Accepted and not dialog.save_for(
            self._user_email
        ):
            QtWidgets.QMessageBox.warning(self, "Save failed", "Could not save record.")

    def _show_plot(self, metric: str) -> None:
        """Show a plot window for the logged-in user and requested metric."""
        if self._user_email is None:
            return
        if metric == "income":
            self._income_plot = MonthlyPlotWindow(self._user_email, metric, self)
            self._income_plot.show()
        else:
            self._expense_plot = MonthlyPlotWindow(self._user_email, metric, self)
            self._expense_plot.show()

    def _refresh_currency_rates(self) -> None:
        """Start an asynchronous currency refresh if one is not already running."""
        if self._currency_thread is not None:
            return
        self._currency_thread = QtCore.QThread(self)
        self._currency_worker = CurrencyWorker(
            CurrencyService(get_settings().navasan_api_key)
        )
        self._currency_worker.moveToThread(self._currency_thread)
        self._currency_thread.started.connect(self._currency_worker.fetch)
        self._currency_worker.finished.connect(self._display_rates)
        self._currency_worker.failed.connect(self._display_rate_error)
        self._currency_worker.finished.connect(self._currency_thread.quit)
        self._currency_worker.failed.connect(self._currency_thread.quit)
        self._currency_thread.finished.connect(self._currency_worker.deleteLater)
        self._currency_thread.finished.connect(self._clear_currency_thread)
        self._currency_thread.start()

    def _display_rates(self, rates: Sequence[CurrencyRate]) -> None:
        """Render currency rates returned by the worker."""
        for row, rate in enumerate(rates):
            self._rates_table.setItem(row, 0, QtWidgets.QTableWidgetItem(rate.name))
            self._rates_table.setItem(row, 1, QtWidgets.QTableWidgetItem(rate.value))

    def _display_rate_error(self, message: str) -> None:
        """Keep the UI responsive while reporting a currency refresh failure."""
        self.statusBar().showMessage(f"Could not refresh rates: {message}", 6_000)

    def _clear_currency_thread(self) -> None:
        """Release the completed worker thread reference."""
        if self._currency_thread is not None:
            self._currency_thread.deleteLater()
        self._currency_thread = None
        self._currency_worker = None
