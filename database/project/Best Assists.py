from sqlalchemy import create_engine
import pandas as pd
from PyQt5.QtWidgets import QApplication, QMainWindow, QTableWidget, QTableWidgetItem, QVBoxLayout, QWidget, QHeaderView, QLabel
from PyQt5 import QtGui, QtWidgets
from PyQt5.QtCore import Qt, QSize
import sys

server_name = r'DESKTOP-L4ENO1K\NEWSQLSERVER'
driver = 'ODBC Driver 17 for SQL Server'
database = 'Soccer_LeagueDB'

connection_string = f"mssql+pyodbc://{server_name}/{database}?driver={driver.replace(' ', '+')}"
engine = create_engine(connection_string)

query = """
select TOP 10 p.player_photo_url as _ , (p.first_name + ' ' + p.last_name) as Name, p.asists_numbers as Asists, t.team_name as Team
from Player as p 
join Team as t on p.team_id = t.team_id
order by asists_numbers desc;
"""
try:
    df = pd.read_sql(query, engine)
except Exception as e:
    print("Database error:", e)
    sys.exit(1)

class LeagueTableWindow(QMainWindow):
    def __init__(self, df):
        super().__init__()
        self.setWindowTitle("League Best Assists Table")
        self.setWindowIcon(QtGui.QIcon("Bests.png"))
        self.setFixedSize(1470,1000)


        icon_size = 130
        self.table_widget = QTableWidget()
        self.table_widget.setRowCount(df.shape[0])
        self.table_widget.setColumnCount(df.shape[1])
        self.table_widget.setHorizontalHeaderLabels(df.columns)

        self.table_widget.setIconSize(QSize(icon_size, icon_size))
        self.table_widget.setColumnWidth(0, icon_size + 20)
        self.table_widget.verticalHeader().setDefaultSectionSize(icon_size + 20)
        self.table_widget.setStyleSheet("QTableWidget { font-size: 25px; }")


        self.table_widget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        # self.table_widget.verticalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table_widget.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)


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

        layout = QVBoxLayout()
        layout.addWidget(self.table_widget)
        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    import qdarkstyle
    with open("theme.qss", "r") as f:
        app.setStyleSheet(f.read())

    window = LeagueTableWindow(df)
    window.show()

    sys.exit(app.exec_())

