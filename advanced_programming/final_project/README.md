# Economy Manager - Advanced Programming Final Project

This project is a desktop financial management application built with Python and PyQt5. Its purpose is to help a user track daily income and expenses, store financial records, visualize them through charts, and monitor exchange rates in real time.

## Project Overview

The application provides a simple but functional personal finance dashboard. Users can:
- create an account and log in securely,
- add daily income and expense values from a calendar-based dialog,
- save entries per month and year using serialized local files,
- view monthly income and expense plots,
- monitor selected currency exchange rates through an API.

## Main Features

- User authentication flow with sign-up and login dialogs
- Persistent storage of user data using Python pickle files
- Daily financial entry management through a calendar interface
- Monthly income and expense visualization with PyQtGraph
- Exchange-rate monitoring from the Navasan API
- Simple and clean GUI built with PyQt5

## Project Structure

- main.py: application entry point and main window UI
- dialogs.py: login/signup dialogs and validation logic
- database.py: user data persistence and monthly income/expense storage
- api.py: external API integration for currency prices
- plots.py: plotting widgets for income and expense trends
- users/: user-specific storage directory

## Technologies Used

- Python 3
- PyQt5
- PyQtGraph
- requests
- pickle for local data persistence

## Requirements to Run

Install the required packages:

```bash
pip install PyQt5 PyQtGraph requests
```

Run the application:

```bash
python main.py
```

## How the Project Works

1. The app starts with a login/sign-up window.
2. After authentication, the user can select a date from the calendar.
3. A dialog prompts for income and expenses for that day.
4. The values are stored in month-based files under each user directory.
5. The user can open monthly plots to visualize recorded financial activity.
6. Currency values are fetched from the public API and displayed in the main window.

## Notes

This project is a practical example of combining GUI programming, file storage, API usage, and data visualization in a single desktop application.
