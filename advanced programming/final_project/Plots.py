from PyQt5 import QtWidgets, QtCore,QtGui
from pyqtgraph import PlotWidget, plot
import pyqtgraph as pg
import pickle
import os
class income_plot(QtWidgets.QWidget):
    def __init__(self, email):
        super().__init__()
        self.email = email
        self.setFixedSize(800,600)
        self.setWindowTitle("Income Plots")
        self.setWindowIcon(QtGui.QIcon("profit.png"))
        self.lay = QtWidgets.QGridLayout()
        self.setLayout(self.lay)
        self.days = []
        for i in range(1,32):
            self.days.append(i)
        self.lable = QtWidgets.QLabel(self)
        self.combo = QtWidgets.QComboBox()
        self.combo.addItems(["Select month", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        self.combo.currentIndexChanged.connect(self.month_change)
        self.lay.addWidget(self.combo)
        self.lay.addWidget(self.lable)
    def month_change(self):
        show_graph = None
        if self.combo.currentText() == "Jan":
            show_graph = self.Jan_month()
        elif self.combo.currentText() == "Feb":
            show_graph = self.Feb_month()
        elif self.combo.currentText() == "Mar":
            show_graph = self.Mar_month()
        elif self.combo.currentText() == "Apr":
            show_graph = self.Apr_month()
        elif self.combo.currentText() == "May":
            show_graph =  self.May_month()
        elif self.combo.currentText() == "Jun":
            show_graph = self.Jan_month()
        elif self.combo.currentText() == "Jul":
            show_graph = self.Jul_month()
        elif self.combo.currentText() == "Aug":
            show_graph = self.Aug_month()
        elif self.combo.currentText() == "Sep":
            show_graph = self.Sep_month()
        elif self.combo.currentText() == "Oct":
            show_graph = self.Oct_month()
        elif self.combo.currentText() == "Nov":
            show_graph = self.Nov_month()
        elif self.combo.currentText() == "Dec":
            show_graph = self.Dec_month()
        pen = pg.mkPen(color=(0,0,255), width=5)
        show_graph.setRange(xRange=[0,31])
        styles = {'color':'b', 'font-size':'20px'}
        show_graph.setLabel('left', 'Incomes', **styles)
        show_graph.setLabel('bottom', 'Days', **styles)
        show_graph.setTitle("Your Monthly Income Report",color="b", size="14pt")
        show_graph.plot(self.days, self.data, pen=pen, symbol ="o")
        self.lay.addWidget(show_graph,1,0)
    def Jan_month(self):
        self.JanGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M01-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M01-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JanGraph
    def Feb_month(self):
        self.FebGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M02-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M02-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data = zero_data
        return self.FebGraph
    def Mar_month(self):
        self.MarGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(1)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M03-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M03-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.MarGraph
    def Apr_month(self):
        self.AprGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(1)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M04-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M04-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.AprGraph
    def May_month(self):
        self.MayGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(1)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M05-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M05-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.MayGraph
    def Jun_month(self):
        self.JunGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(1)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M06-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M06-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JunGraph
    def Jul_month(self):
        self.JulGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(1)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M07-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M07-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JulGraph
    def Aug_month(self):
        self.AugGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M08-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M08-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.AugGraph
    def Sep_month(self):
        self.SepGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M09-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M09-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.SepGraph
    def Oct_month(self):
        self.OctGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M10-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M10-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.OctGraph
    def Nov_month(self):
        self.NovGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M11-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M11-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.NovGraph
    def Dec_month(self):
        self.DecGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M12-income.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M12-income.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.DecGraph
class expenses_plot(QtWidgets.QWidget):
    def __init__(self, email):
        super().__init__()
        self.email = email
        self.setFixedSize(800,600)
        self.setWindowTitle("Expenses Plots")
        self.setWindowIcon(QtGui.QIcon("profit.png"))
        self.lay = QtWidgets.QGridLayout()
        self.setLayout(self.lay)
        self.days = []
        for i in range(1,32):
            self.days.append(i)
        self.label = QtWidgets.QLabel(self)
        self.combo = QtWidgets.QComboBox()
        self.combo.addItems(["Select month", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        self.combo.currentIndexChanged.connect(self.month_change)
        self.lay.addWidget(self.combo)
        self.lay.addWidget(self.label)
    def month_change(self):
        show_graph = None
        if self.combo.currentText() == "Jan":
            show_graph = self.Jan_month()
        elif self.combo.currentText() == "Feb":
            show_graph = self.Feb_month()
        elif self.combo.currentText() == "Mar":
            show_graph = self.Mar_month()
        elif self.combo.currentText() == "Apr":
            show_graph = self.Apr_month()
        elif self.combo.currentText() == "May":
            show_graph =  self.May_month()
        elif self.combo.currentText() == "Jun":
            show_graph = self.Jan_month()
        elif self.combo.currentText() == "Jul":
            show_graph = self.Jul_month()
        elif self.combo.currentText() == "Aug":
            show_graph = self.Aug_month()
        elif self.combo.currentText() == "Sep":
            show_graph = self.Sep_month()
        elif self.combo.currentText() == "Oct":
            show_graph = self.Oct_month()
        elif self.combo.currentText() == "Nov":
            show_graph = self.Nov_month()
        elif self.combo.currentText() == "Dec":
            show_graph = self.Dec_month()
        pen = pg.mkPen(color=(0,0,255), width=5)
        show_graph.setRange(xRange=[0,31])
        styles = {'color':'b', 'font-size':'20px'}
        show_graph.setLabel('left', 'Expenses', **styles)
        show_graph.setLabel('bottom', 'Days', **styles)
        show_graph.setTitle("Your Monthly Expenses Report",color="b", size="14pt")
        show_graph.plot(self.days, self.data, pen=pen, symbol ="o")
        show_graph.plot(self.days, self.data)
        self.lay.addWidget(show_graph,1,0)
    def Jan_month(self):
        self.JanGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M01-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M01-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JanGraph
    def Feb_month(self):
        self.FebGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M02-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M02-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data = zero_data
        return self.FebGraph
    def Mar_month(self):
        self.MarGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M03-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M03-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.MarGraph
    def Apr_month(self):
        self.AprGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M04-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M04-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.AprGraph
    def May_month(self):
        self.MayGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M05-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M05-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.MayGraph
    def Jun_month(self):
        self.JunGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M06-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M06-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JunGraph
    def Jul_month(self):
        self.JulGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M07-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M07-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.JulGraph
    def Aug_month(self):
        self.AugGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M08-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M08-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.AugGraph
    def Sep_month(self):
        self.SepGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M09-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M09-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.SepGraph
    def Oct_month(self):
        self.OctGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M10-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M10-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.OctGraph
    def Nov_month(self):
        self.NovGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M11-expenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M11-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.NovGraph
    def Dec_month(self):
        self.DecGraph = pg.PlotWidget()
        zero_data =  []
        for i in range(1,32):
                    zero_data.append(0)
        if os.path.isfile(f"/home/ali/University/Project/users/{self.email}/2023/M12-iexpenses.bin"):
            with open(f"/home/ali/University/Project/users/{self.email}/2023/M12-expenses.bin", "rb") as f:
                self.data =  pickle.load(f)
        else:
            self.data =  zero_data
        return self.DecGraph