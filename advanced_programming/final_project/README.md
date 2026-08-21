# Economy Manager - Advanced Programming Final Project

This project is a desktop financial management application built with Python and PyQt5. Its purpose is to help a user track daily income and expenses, store financial records, visualize them through charts, and monitor exchange rates in real time.

## Project Overview

The application provides a simple but functional personal finance dashboard. Users can:

- create an account and log in securely,
- add daily income and expense values from a calendar-based dialog,
- save entries securely in PostgreSQL through SQLAlchemy,
- view monthly income and expense plots,
- monitor selected currency exchange rates through an API.

## Main Features

- User authentication flow with sign-up and login dialogs
- PostgreSQL persistence with scoped SQLAlchemy sessions
- Daily financial entry management through a calendar interface
- Monthly income and expense visualization with PyQtGraph
- Exchange-rate monitoring from the Navasan API
- Simple and clean GUI built with PyQt5

## Project Structure

- main.py: application entry point
- core/: environment configuration and shared application settings
- database/: SQLAlchemy models, session lifecycle, and repositories
- services/: external integrations such as Navasan currency rates
- ui/: Qt windows, dialogs, plots, and background workers

## Technologies Used

- Python 3
- PyQt5
- PyQtGraph
- requests
- pickle for local data persistence

## Requirements to Run

Install the required packages:

```bash
pip install PyQt5 PyQtGraph SQLAlchemy psycopg2-binary bcrypt python-dotenv requests QDarkStyle
```

Run the application:

```bash
python main.py
```

## How the Project Works

1. The app starts with a login/sign-up window.
2. After authentication, the user can select a date from the calendar.
3. A dialog prompts for income and expenses for that day.
4. Values are stored in PostgreSQL, one record per user and day.
5. The user can open monthly plots to visualize recorded financial activity.
6. Currency values are fetched in a Qt worker thread and displayed without freezing the UI.

## Notes

This project is a practical example of combining GUI programming, file storage, API usage, and data visualization in a single desktop application.
