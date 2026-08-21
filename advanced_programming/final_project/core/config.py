"""Configuration loading for Economy Manager."""

from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path

from dotenv import load_dotenv


PROJECT_ROOT = Path(__file__).resolve().parent.parent
load_dotenv(PROJECT_ROOT / ".env")


@dataclass(frozen=True)
class Settings:
    """Runtime settings loaded from environment variables."""

    database_url: str
    navasan_api_key: str | None
    assets_directory: Path


def get_settings() -> Settings:
    """Return validated settings required by the application."""
    database_url = os.getenv("DATABASE_URL")
    if not database_url:
        raise RuntimeError("DATABASE_URL must be set in the .env file.")

    return Settings(
        database_url=database_url,
        navasan_api_key=os.getenv("NAVASAN_API_KEY"),
        assets_directory=PROJECT_ROOT,
    )
