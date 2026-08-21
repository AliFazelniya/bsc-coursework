"""SQLAlchemy ORM models for the application."""

from __future__ import annotations

from datetime import date

from sqlalchemy import (
    Column,
    Date,
    Float,
    ForeignKey,
    Integer,
    String,
    UniqueConstraint,
)
from sqlalchemy.orm import declarative_base, relationship


Base = declarative_base()


class User(Base):
    """A registered Economy Manager user."""

    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), nullable=False)
    email = Column(String(100), unique=True, nullable=False, index=True)
    phone = Column(String(20), nullable=False)
    password_hash = Column(String(255), nullable=False)
    transactions = relationship(
        "Transaction", back_populates="user", cascade="all, delete-orphan"
    )


class Transaction(Base):
    """An income and expense record for one user and calendar day."""

    __tablename__ = "transactions"
    __table_args__ = (
        UniqueConstraint("user_id", "record_date", name="uq_user_transaction_date"),
    )

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    record_date = Column(Date, nullable=False, default=date.today)
    income = Column(Float, nullable=False, default=0.0)
    expense = Column(Float, nullable=False, default=0.0)
    user = relationship("User", back_populates="transactions")
