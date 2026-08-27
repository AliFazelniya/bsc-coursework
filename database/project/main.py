from sqlalchemy import create_engine
import pandas as pd
from PyQt5.QtWidgets import (QApplication, QMainWindow, QTableWidget, QTableWidgetItem, 
                             QVBoxLayout, QWidget, QHBoxLayout, QHeaderView, QLabel, 
                             QPushButton, QStackedWidget, QMessageBox)
from PyQt5 import QtGui, QtWidgets
from PyQt5.QtCore import Qt, QSize
import sys
import os
from urllib.parse import quote_plus
from dotenv import load_dotenv
load_dotenv()
# ==========================================
# 1. Database Configuration
# ==========================================
server = "127.0.0.1"
username = "sa"
password = os.environ["DB_PASSWORD"]
database = "Soccer_LeagueDB"

connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={server},1433;"
    f"DATABASE={database};"
    f"UID={username};"
    f"PWD={password};"
    "TrustServerCertificate=yes;"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={quote_plus(connection_string)}"
)

# ==========================================
# 2. Queries Configuration Dictionary
# ==========================================
QUERIES = {
    "standings": {
        "title": "🏆 League Standings",
        "icon_size": 90,
        "query": """
            SELECT team_logo_url as Logo, team_name as Name, MP, Wins, Draws, Losts, GF, GA, GD, points
            FROM Team
            ORDER BY points DESC, GD DESC
        """
    },
    "strikers": {
        "title": "👟 Best Strikers",
        "icon_size": 130,
        "query": """
            SELECT TOP 10 p.player_photo_url as _ , (p.first_name + ' ' + p.last_name) as Name, p.goals_number as Goals, t.team_name as Team
            FROM Player as p
            JOIN Team as t on p.team_id = t.team_id
            ORDER BY goals_number DESC;
        """
    },
    "assists": {
        "title": "🎯 Best Assists",
        "icon_size": 130,
        "query": """
            SELECT TOP 10 p.player_photo_url as _ , (p.first_name + ' ' + p.last_name) as Name, p.assists_numbers as Assists, t.team_name as Team
            FROM Player as p 
            JOIN Team as t on p.team_id = t.team_id
            ORDER BY assists_numbers DESC;
        """
    },
    "players": {
        "title": "🏃 All Players",
        "icon_size": 130,
        "query": """
            SELECT p.player_photo_url as _, (p.first_name + ' ' + p.last_name) as Name , p.age as Age, p.nationality as Nationality, p.position as Position, p.market_value as Value,  p.OVR , p.goals_number as Goals, p.assists_numbers as Assists, t.team_name as Team
            FROM Player as p
            JOIN Team as t on p.team_id = t.team_id
        """
    },
    "coaches": {
        "title": "📋 Coaches Table",
        "icon_size": 130,
        "query": """
            SELECT c.coach_photo_url as _, (c.first_name + ' ' + c.last_name) as Name, c.obligation as Obligation, t.team_name as Team
            FROM Coach as c
            JOIN Team as t on c.team_id = t.team_id
        """
    },
    "head_coaches": {
        "title": "👔 Head Coaches Table",
        "icon_size": 130,
        "query": """
            SELECT hc.head_coach_photo_url as _, (hc.first_name + ' ' + hc.last_name) as Name , t.team_name as Team
            FROM head_coach as hc
            JOIN Team as t on hc.team_id = t.team_id
        """
    }
}

# ==========================================
# 3. Dynamic Table Page Component
# ==========================================
class DataTablePage(QWidget):
    def __init__(self, df, config, back_callback):
        super().__init__()
        layout = QVBoxLayout()
        
        # --- Top Header Layout (Back Button + Title) ---
        header_layout = QHBoxLayout()
        
        back_btn = QPushButton("⬅ Back to Menu")
        back_btn.setFixedSize(150, 40)
        back_btn.setStyleSheet("font-size: 16px; font-weight: bold;")
        back_btn.clicked.connect(back_callback)
        
        title_label = QLabel(config["title"])
        title_label.setStyleSheet("font-size: 28px; font-weight: bold; color: #00ffe0;")
        title_label.setAlignment(Qt.AlignCenter)
        
        # Add a blank label on the right to keep the title perfectly centered
        dummy_label = QLabel()
        dummy_label.setFixedWidth(150)

        header_layout.addWidget(back_btn)
        header_layout.addWidget(title_label)
        header_layout.addWidget(dummy_label)
        
        layout.addLayout(header_layout)
        
        # --- Table Setup ---
        icon_size = config["icon_size"]
        self.table_widget = QTableWidget()
        self.table_widget.setRowCount(df.shape[0])
        self.table_widget.setColumnCount(df.shape[1])
        self.table_widget.setHorizontalHeaderLabels(df.columns)

        self.table_widget.setIconSize(QSize(icon_size, icon_size))
        self.table_widget.setColumnWidth(0, icon_size + 20)
        self.table_widget.verticalHeader().setDefaultSectionSize(icon_size + 20)
        
        font_size = "20px" if icon_size == 90 else "25px"
        self.table_widget.setStyleSheet(f"QTableWidget {{ font-size: {font_size}; }}")

        self.table_widget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table_widget.horizontalHeader().setSectionResizeMode(0, QHeaderView.Fixed) # Keep image column fixed
        
        if icon_size == 90:
            self.table_widget.verticalHeader().setSectionResizeMode(QHeaderView.Stretch)

        self.table_widget.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)

        # --- Populate Table ---
        for row in range(df.shape[0]):
            for col in range(df.shape[1]):
                if col == 0:
                    label = QLabel()
                    pixmap = QtGui.QPixmap(df.iat[row, col]).scaled(icon_size, icon_size, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                    label.setPixmap(pixmap)
                    label.setAlignment(Qt.AlignCenter)
                    self.table_widget.setCellWidget(row, col, label)
                else:
                    item = QTableWidgetItem(str(df.iat[row, col]))
                    item.setTextAlignment(Qt.AlignCenter)
                    self.table_widget.setItem(row, col, item)

        layout.addWidget(self.table_widget)
        self.setLayout(layout)

# ==========================================
# 4. Main Application Window
# ==========================================
class MainLeagueApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Soccer League Dashboard")
        self.setWindowIcon(QtGui.QIcon("images/logos/league_logo.png"))
        self.setFixedSize(1470, 1000)

        # QStackedWidget acts like a multi-page book
        self.stacked_widget = QStackedWidget()
        self.setCentralWidget(self.stacked_widget)

        # Create and add Menu Page
        self.menu_page = QWidget()
        self.setup_menu_page()
        self.stacked_widget.addWidget(self.menu_page)

    def setup_menu_page(self):
        layout = QVBoxLayout()
        layout.setAlignment(Qt.AlignCenter)

        # Dashboard Title
        title = QLabel("⚽ Soccer League Dashboard")
        title.setStyleSheet("font-size: 45px; font-weight: bold; margin-bottom: 40px; color: #00ffe0;")
        title.setAlignment(Qt.AlignCenter)
        layout.addWidget(title)

        # Buttons List mapping to the QUERIES keys
        buttons = [
            ("🏆 League Standings", "standings"),
            ("👟 Best Strikers", "strikers"),
            ("🎯 Best Assists", "assists"),
            ("🏃 All Players Table", "players"),
            ("👔 Head Coaches", "head_coaches"),
            ("📋 Assistant Coaches", "coaches")
        ]

        for btn_text, key in buttons:
            btn = QPushButton(btn_text)
            btn.setFixedSize(450, 70)
            btn.setStyleSheet("font-size: 22px; font-weight: bold;")
            
            # Using lambda to pass the specific 'key' to the function
            btn.clicked.connect(lambda checked, k=key: self.load_table_view(k))
            
            # Layout to center the button
            btn_layout = QHBoxLayout()
            btn_layout.setAlignment(Qt.AlignCenter)
            btn_layout.addWidget(btn)
            
            layout.addLayout(btn_layout)
            
        self.menu_page.setLayout(layout)

    def load_table_view(self, key):
        config = QUERIES[key]
        
        # 1. Fetch Data from DB
        try:
            df = pd.read_sql(config["query"], engine)
        except Exception as e:
            QMessageBox.critical(self, "Database Error", f"Failed to fetch data:\n{str(e)}")
            return

        # 2. Create the Table Page dynamically
        table_page = DataTablePage(df, config, back_callback=self.show_menu)
        
        # 3. Add to Stack and Switch
        self.stacked_widget.addWidget(table_page)
        self.stacked_widget.setCurrentWidget(table_page)

    def show_menu(self):
        # 1. Get the current active table page
        current_widget = self.stacked_widget.currentWidget()
        
        # 2. Switch back to menu
        self.stacked_widget.setCurrentWidget(self.menu_page)
        
        # 3. Remove and delete the table page to free memory (RAM)
        self.stacked_widget.removeWidget(current_widget)
        current_widget.deleteLater()

# ==========================================
# 5. Run App
# ==========================================
if __name__ == "__main__":
    app = QApplication(sys.argv)
    
    # Load Theme
    try:
        with open("theme.qss", "r") as f:
            app.setStyleSheet(f.read())
    except FileNotFoundError:
        print("Warning: theme.qss not found. Using default style.")

    # Start Main Window
    window = MainLeagueApp()
    window.show()

    sys.exit(app.exec_())