"""Background workers used by the PyQt interface."""

from __future__ import annotations

from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

from services.currency_service import CurrencyRate, CurrencyService


class CurrencyWorker(QObject):
    """Fetch currency rates off the Qt GUI thread."""

    finished = pyqtSignal(list)
    failed = pyqtSignal(str)

    def __init__(self, service: CurrencyService) -> None:
        super().__init__()
        self._service = service

    @pyqtSlot()
    def fetch(self) -> None:
        """Fetch rates and notify listeners through Qt signals."""
        try:
            rates: list[CurrencyRate] = self._service.fetch_rates()
        except Exception as error:
            self.failed.emit(str(error))
            return
        self.finished.emit(rates)
