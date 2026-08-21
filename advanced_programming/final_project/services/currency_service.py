"""Client for Navasan currency rates."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any

import requests


NAVASAN_LATEST_URL = "https://api.navasan.tech/latest/"


@dataclass(frozen=True)
class CurrencyRate:
    """A display-ready currency rate returned by Navasan."""

    name: str
    value: str


class CurrencyService:
    """Fetch and normalize currency rates from the Navasan API."""

    def __init__(self, api_key: str | None, timeout_seconds: float = 5.0) -> None:
        self._api_key = api_key
        self._timeout_seconds = timeout_seconds

    def fetch_rates(self) -> list[CurrencyRate]:
        """Fetch configured rates or raise ``requests.RequestException``."""
        if not self._api_key:
            raise requests.RequestException("NAVASAN_API_KEY is not configured.")

        response = requests.get(
            NAVASAN_LATEST_URL,
            params={"api_key": self._api_key},
            timeout=self._timeout_seconds,
        )
        response.raise_for_status()
        payload: dict[str, Any] = response.json()
        currencies = (
            ("Dollar", "usd_sell"),
            ("Euro", "eur_hav"),
            ("Pound", "gbp_hav"),
            ("Ether", "eth"),
            ("Bitcoin", "btc"),
            ("Coin", "bahar"),
        )
        return [
            CurrencyRate(name, str(payload.get(key, {}).get("value", "N/A")))
            for name, key in currencies
        ]
