from PyQt5 import QtWidgets, QtGui
import pyqtgraph as pg
import database as db
import datetime

class income_plot(QtWidgets.QWidget):
    def __init__(self, email):
        super().__init__()
        self.email = email
        self.setFixedSize(800, 600)
        self.setWindowTitle("Income Plots")
        self.setWindowIcon(QtGui.QIcon("profit.png"))
        
        self.lay = QtWidgets.QGridLayout()
        self.setLayout(self.lay)
        
        self.days = list(range(1, 32))
        
        self.months = {
            "Jan": 1, "Feb": 2, "Mar": 3, "Apr": 4, "May": 5, "Jun": 6,
            "Jul": 7, "Aug": 8, "Sep": 9, "Oct": 10, "Nov": 11, "Dec": 12
        }
        
        self.combo = QtWidgets.QComboBox()
        self.combo.addItems(["Select month"] + list(self.months.keys()))
        self.combo.currentIndexChanged.connect(self.month_change)
        self.lay.addWidget(self.combo, 0, 0)
        
        self.graph_widget = pg.PlotWidget()
        self.lay.addWidget(self.graph_widget, 1, 0)

    def month_change(self):
        selected_month_name = self.combo.currentText()
        if selected_month_name == "Select month":
            return
            
        month_index = self.months[selected_month_name]
        current_year = datetime.date.today().year
        incomes, _ = db.get_monthly_data(self.email, current_year, month_index)
        

        self.graph_widget.clear()
        self.graph_widget.setRange(xRange=[1, 31])
        
        styles = {'color':'b', 'font-size':'20px'}
        self.graph_widget.setLabel('left', 'Incomes (Rial)', **styles)
        self.graph_widget.setLabel('bottom', 'Days', **styles)
        self.graph_widget.setTitle(f"Your Monthly Income Report - {selected_month_name}", color="b", size="14pt")
        
        pen = pg.mkPen(color=(0,0,255), width=5)
        self.graph_widget.plot(self.days, incomes, pen=pen, symbol="o")