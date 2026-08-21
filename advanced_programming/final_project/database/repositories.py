"""Database operations for users and financial transactions."""

from __future__ import annotations

from calendar import monthrange
from datetime import date

import bcrypt
from sqlalchemy import extract

from database.models import Transaction, User
from database.session import session_scope


def hash_password(password: str) -> str:
    """Hash a password using bcrypt."""
    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")


def _password_matches(password: str, password_hash: str) -> bool:
    """Return whether a plain password matches its bcrypt hash."""
    return bcrypt.checkpw(password.encode("utf-8"), password_hash.encode("utf-8"))


def add_user(username: str, email: str, phone: str, password: str) -> bool:
    """Create a user, returning ``False`` when the email is already registered."""
    with session_scope() as session:
        if session.query(User.id).filter_by(email=email).first() is not None:
            return False
        session.add(
            User(
                username=username,
                email=email,
                phone=phone,
                password_hash=hash_password(password),
            )
        )
        return True


def authenticate_user(email: str, password: str) -> bool:
    """Validate a user's email and password."""
    with session_scope() as session:
        user = session.query(User).filter_by(email=email).first()
        return bool(user and _password_matches(password, user.password_hash))


def get_user_name(email: str) -> str | None:
    """Return a user's display name, if the account exists."""
    with session_scope() as session:
        user = session.query(User.username).filter_by(email=email).first()
        return user[0] if user else None


def save_transaction(
    email: str, record_date: date, income: float, expense: float
) -> bool:
    """Create or update a user's financial record for a date."""
    with session_scope() as session:
        user = session.query(User).filter_by(email=email).first()
        if user is None:
            return False

        transaction = (
            session.query(Transaction)
            .filter_by(user_id=user.id, record_date=record_date)
            .first()
        )
        if transaction is None:
            session.add(
                Transaction(
                    user_id=user.id,
                    record_date=record_date,
                    income=income,
                    expense=expense,
                )
            )
        else:
            transaction.income = income
            transaction.expense = expense
        return True


def get_monthly_data(
    email: str, year: int, month: int
) -> tuple[list[float], list[float]]:
    """Return daily income and expense values for a user's calendar month."""
    days_in_month = monthrange(year, month)[1]
    incomes = [0.0] * days_in_month
    expenses = [0.0] * days_in_month

    with session_scope() as session:
        user = session.query(User).filter_by(email=email).first()
        if user is None:
            return incomes, expenses

        transactions = (
            session.query(Transaction)
            .filter(
                Transaction.user_id == user.id,
                extract("year", Transaction.record_date) == year,
                extract("month", Transaction.record_date) == month,
            )
            .all()
        )
        for transaction in transactions:
            day_index = transaction.record_date.day - 1
            incomes[day_index] = transaction.income
            expenses[day_index] = transaction.expense
    return incomes, expenses
