"""Monthly income and expense plot windows."""

from __future__ import annotations

from datetime import date

import pyqtgraph as pg
from PyQt5 import QtWidgets

from database import get_monthly_data


MONTHS = {
    "January": 1, "February": 2, "March": 3, "April": 4,
    "May": 5, "June": 6, "July": 7, "August": 8,
    "September": 9, "October": 10, "November": 11, "December": 12,
}


class MonthlyPlotWindow(QtWidgets.QWidget):
    """Display a selected user's monthly income or expense trend."""

    def __init__(
        self,
        email: str,
        metric: str,
        parent: QtWidgets.QWidget | None = None,
    ) -> None:
        super().__init__(parent)
        self._email = email
        self._metric = metric
        self.setWindowTitle(f"{metric.title()} Plot")
        self.resize(800, 600)

        layout = QtWidgets.QVBoxLayout(self)
        self._month_combo = QtWidgets.QComboBox()
        self._month_combo.addItems(MONTHS)
        self._month_combo.currentTextChanged.connect(self._plot_month)
        self._plot = pg.PlotWidget()
        layout.addWidget(self._month_combo)
        layout.addWidget(self._plot)
        self._plot_month(self._month_combo.currentText())

    def _plot_month(self, month_name: str) -> None:
        """Fetch and render the selected month."""
        month = MONTHS[month_name]
        year = date.today().year
        incomes, expenses = get_monthly_data(self._email, year, month)
        values = incomes if self._metric == "income" else expenses
        days = list(range(1, len(values) + 1))

        self._plot.clear()
        self._plot.setLabel("left", f"{self._metric.title()} (Rial)")
        self._plot.setLabel("bottom", "Day")
        self._plot.setTitle(f"{month_name} {year} {self._metric.title()}")
        self._plot.plot(days, values, pen=pg.mkPen("#4ca3ff", width=3), symbol="o")
