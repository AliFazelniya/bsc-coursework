# Soccer League Dashboard

A desktop soccer league dashboard built with **Python, PyQt5, Pandas, SQLAlchemy, and Microsoft SQL Server**.

## Features

- League standings
- Best strikers
- Best assists
- All players table
- Head coaches
- Assistant coaches
- Team, player, and coach images
- 🎨 Custom PyQt5 interface with QSS styling

## Project Structure

```text
project/
├── images/
│   ├── coaches/
│   ├── head_coaches/
│   ├── logos/
│   ├── players/
│   └── teams/
├── notes/
├── database.sql
├── main.py
├── requirements.txt
├── README.md
└── theme.qss
```

## Technologies

- Python 3
- PyQt5
- Pandas
- SQLAlchemy
- PyODBC
- python-dotenv
- Microsoft SQL Server

## Database

The project uses the **Soccer_LeagueDB** database on SQL Server.

Database configuration is loaded from `.env`:

```env
DB_PASSWORD=your_password
```

The SQL Server connection is configured for:

```text
Server: 127.0.0.1
Port: 1433
Database: Soccer_LeagueDB
User: sa
```

Run `database.sql` to create and populate the database.

## Run

Create and activate a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the application from the project root:

```bash
python3 main.py
```
