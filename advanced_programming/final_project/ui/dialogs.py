"""Authentication and transaction dialogs."""

from __future__ import annotations

import re
from datetime import date

from PyQt5 import QtCore, QtGui, QtWidgets

from database import add_user, authenticate_user, save_transaction


EMAIL_PATTERN = re.compile(r"^[^@/s]+@[^@/s]+/.[^@/s]+$")


def _show_error(parent: QtWidgets.QWidget, title: str, message: str) -> None:
    """Display a standard validation error dialog."""
    QtWidgets.QMessageBox.warning(parent, title, message)


class LoginDialog(QtWidgets.QDialog):
    """Dialog that authenticates and returns an account email."""

    def __init__(self, parent: QtWidgets.QWidget | None = None) -> None:
        super().__init__(parent)
        self.email: str | None = None
        self.setWindowTitle("Log in")
        self.setFixedSize(420, 260)

        layout = QtWidgets.QVBoxLayout(self)
        layout.addWidget(QtWidgets.QLabel("Enter your account credentials."))
        self.email_input = QtWidgets.QLineEdit(placeholderText="Email")
        self.password_input = QtWidgets.QLineEdit(placeholderText="Password")
        self.password_input.setEchoMode(QtWidgets.QLineEdit.Password)
        layout.addWidget(self.email_input)
        layout.addWidget(self.password_input)

        buttons = QtWidgets.QDialogButtonBox(
            QtWidgets.QDialogButtonBox.Cancel | QtWidgets.QDialogButtonBox.Ok
        )
        buttons.accepted.connect(self._authenticate)
        buttons.rejected.connect(self.reject)
        layout.addWidget(buttons)

    def _authenticate(self) -> None:
        """Validate the entered credentials and accept on success."""
        email = self.email_input.text().strip().lower()
        if authenticate_user(email, self.password_input.text()):
            self.email = email
            self.accept()
            return
        _show_error(self, "Login failed", "Invalid email or password.")


class SignupDialog(QtWidgets.QDialog):
    """Dialog that creates a new Economy Manager account."""

    def __init__(self, parent: QtWidgets.QWidget | None = None) -> None:
        super().__init__(parent)
        self.setWindowTitle("Sign up")
        self.setFixedSize(420, 360)

        layout = QtWidgets.QFormLayout(self)
        self.name_input = QtWidgets.QLineEdit()
        self.email_input = QtWidgets.QLineEdit()
        self.phone_input = QtWidgets.QLineEdit()
        self.phone_input.setValidator(
            QtGui.QRegularExpressionValidator(
                QtCore.QRegularExpression(r"/+?[0-9]{7,20}")
            )
        )
        self.password_input = QtWidgets.QLineEdit()
        self.password_confirmation_input = QtWidgets.QLineEdit()
        password_fields = (self.password_input, self.password_confirmation_input)
        for field in password_fields:
            field.setEchoMode(QtWidgets.QLineEdit.Password)

        layout.addRow("Name", self.name_input)
        layout.addRow("Email", self.email_input)
        layout.addRow("Phone", self.phone_input)
        layout.addRow("Password", self.password_input)
        layout.addRow("Confirm password", self.password_confirmation_input)
        buttons = QtWidgets.QDialogButtonBox(
            QtWidgets.QDialogButtonBox.Cancel | QtWidgets.QDialogButtonBox.Ok
        )
        buttons.accepted.connect(self._create_account)
        buttons.rejected.connect(self.reject)
        layout.addRow(buttons)

    def _create_account(self) -> None:
        """Validate and persist the new user account."""
        username = self.name_input.text().strip()
        email = self.email_input.text().strip().lower()
        phone = self.phone_input.text().strip()
        password = self.password_input.text()

        if not username or not phone or not password:
            _show_error(self, "Missing information", "Complete every required field.")
        elif not EMAIL_PATTERN.fullmatch(email):
            _show_error(self, "Invalid email", "Enter a valid email address.")
        elif password != self.password_confirmation_input.text():
            _show_error(self, "Invalid password", "Passwords do not match.")
        elif not add_user(username, email, phone, password):
            _show_error(self, "Email exists", "An account already uses this email.")
        else:
            QtWidgets.QMessageBox.information(
                self, "Account created", "You can now log in."
            )
            self.accept()


class TransactionDialog(QtWidgets.QDialog):
    """Dialog for recording income and expenses for a selected date."""

    def __init__(
        self,
        record_date: date,
        parent: QtWidgets.QWidget | None = None,
    ) -> None:
        super().__init__(parent)
        self.setWindowTitle("Enter Values")
        self.setFixedSize(360, 180)
        self._record_date = record_date

        layout = QtWidgets.QFormLayout(self)
        layout.addRow(QtWidgets.QLabel(f"Record for {record_date.isoformat()}"))
        validator = QtGui.QDoubleValidator(0.0, 1_000_000_000_000.0, 2, self)
        validator.setNotation(QtGui.QDoubleValidator.StandardNotation)
        self.income_input = QtWidgets.QLineEdit()
        self.expense_input = QtWidgets.QLineEdit()
        self.income_input.setValidator(validator)
        self.expense_input.setValidator(validator)
        layout.addRow("Income (rial)", self.income_input)
        layout.addRow("Expenses (rial)", self.expense_input)
        buttons = QtWidgets.QDialogButtonBox(
            QtWidgets.QDialogButtonBox.Cancel | QtWidgets.QDialogButtonBox.Save
        )
        buttons.accepted.connect(self.accept)
        buttons.rejected.connect(self.reject)
        layout.addRow(buttons)

    def save_for(self, email: str) -> bool:
        """Persist the values for ``email`` and report whether it succeeded."""
        income = float(self.income_input.text() or 0)
        expense = float(self.expense_input.text() or 0)
        return save_transaction(email, self._record_date, income, expense)
