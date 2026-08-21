"""Economy Manager application entry point."""

from __future__ import annotations

import sys

from PyQt5 import QtWidgets

from database import initialize_database
from ui.main_window import MainWindow

import qdarkstyle

def main() -> int:
    """Initialize dependencies and start the Qt event loop."""
    initialize_database()
    app = QtWidgets.QApplication(sys.argv)
    app.setStyleSheet(qdarkstyle.load_stylesheet(qt_api='pyqt5'))
    window = MainWindow()
    window.show()
    return app.exec_()


if __name__ == "__main__":
    sys.exit(main())
