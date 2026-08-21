# Economy Manager

Economy Manager is a PyQt5 desktop application for recording daily income and
expenses, reviewing monthly trends, and viewing selected currency rates.
Financial data is stored in PostgreSQL through SQLAlchemy.

## Features

- Account registration and bcrypt-protected password authentication
- One income and expense record per user for each calendar day
- Monthly income and expense charts built with PyQtGraph
- PostgreSQL persistence with transaction-scoped SQLAlchemy sessions
- Navasan currency-rate display that refreshes on a background Qt thread
- Environment-based configuration for database and API credentials

## Architecture

```text
.
├── main.py                 # Application entry point
├── core/
│   └── config.py            # .env loading and application settings
├── database/
│   ├── models.py            # SQLAlchemy User and Transaction models
│   ├── repositories.py      # User and transaction data operations
│   └── session.py           # Engine, sessions, and schema initialization
├── services/
│   └── currency_service.py  # Navasan HTTP client
├── ui/
│   ├── dialogs.py           # Authentication and transaction dialogs
│   ├── main_window.py       # Main dashboard window
│   ├── plots.py             # Monthly chart windows
│   └── workers.py           # Non-blocking currency-rate worker
└── docker-compose.yml       # Local PostgreSQL service
```

The root-level `api.py`, `database.py`, `dialogs.py`, `models.py`, and
`plots.py` modules are compatibility exports. New code should import from the
packages shown above.

## Requirements

- Python 3.10 or newer
- PostgreSQL 15 or newer, or Docker Compose
- A Navasan API key for currency-rate data

Install the Python dependencies:

```bash
python3 -m pip install PyQt5 PyQtGraph SQLAlchemy psycopg2-binary bcrypt python-dotenv requests
```

## Configuration

Create a `.env` file in the project root. Do not commit it.

```dotenv
DATABASE_URL=postgresql+psycopg2://admin:adminpassword@localhost:5432/economydb
NAVASAN_API_KEY=your_navasan_api_key
```

`DATABASE_URL` is required. When `NAVASAN_API_KEY` is absent or invalid, the
application still starts; the dashboard reports that currency rates could not
be refreshed.

## Run Locally

Start PostgreSQL with Docker Compose:

```bash
docker compose up -d
```

Then start the desktop application:

```bash
python3 main.py
```

On startup, the application creates any missing database tables. The Compose
configuration exposes PostgreSQL on `localhost:5432` with the example
credentials used above.

## Usage

1. Choose **Account → Sign up** to create an account.
2. Choose **Account → Log in** and enter the account credentials.
3. Select a calendar date, enter income and expenses in rial, then save.
4. Open an income or expense plot and select a month to review that year's
   daily values.
5. Use **Refresh rates** to fetch the latest configured Navasan rates without
   blocking the interface.

## Data Model

- **User**: username, unique email, phone number, and bcrypt password hash.
- **Transaction**: user, record date, income, and expense.

Each user can have only one transaction record for a given date. Saving the
same date again updates that existing record.

## Development Notes

- Database writes use `session_scope()`, which commits on success, rolls back
  on failure, and always closes the SQLAlchemy session.
- Network calls are isolated in `CurrencyWorker` and communicate with the GUI
  through Qt signals, so HTTP requests never run on the main UI thread.
- Update the Docker credentials and matching `DATABASE_URL` before deploying
  beyond local development.
