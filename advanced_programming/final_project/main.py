import typing
from PyQt5 import QtWidgets, QtCore, QtGui
import sys
import dialogs
import plots
import api
import database as db

class Main(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Economy Manager")
        self.setWindowIcon(QtGui.QIcon("profit.png"))
        self.setFixedSize(1270,640)
        wid = QtWidgets.QWidget(self)
        self.setCentralWidget(wid)
        lay = QtWidgets.QGridLayout()
        wid.setLayout(lay)
        self.calender = QtWidgets.QCalendarWidget(self)
        self.calender.resize(300,300)
        self.calender.setGridVisible(True)
        lay.addWidget(self.calender)
        self.calender.selectionChanged.connect(self.show_dialog)
        self.plain_text = QtWidgets.QPlainTextEdit()
        self.plain_text.setPlainText("Wellcome!\nThis is Economy Manager, your assisstant for your professional life!\nAccording to insert and save incomes and expenses of your day, you can click on the calender and insert them. \nWe will use these informations for plots which will report your status. By cliking at show polt, you can see those: ")
        self.plain_text.setFont(QtGui.QFont("Brada Sans",12))
        self.plain_text.setReadOnly(True)
        lay.addWidget(self.plain_text, 1,0)
        self.plot_button = QtWidgets.QPushButton()
        self.plot_button.setText("Show Income PLots")
        lay.addWidget(self.plot_button, 2,0)
        self.plot_button1 = QtWidgets.QPushButton()
        self.plot_button1.setText("Show Expenses PLots")
        lay.addWidget(self.plot_button1, 3,0)
        self.gift_label = QtWidgets.QLabel(self)
        gif = QtGui.QMovie("giphy.gif")
        gif.setScaledSize(QtCore.QSize().scaled(700, 250, QtCore.Qt.KeepAspectRatio))
        self.gift_label.setMovie(gif)
        self.gift_label.setAlignment(QtCore.Qt.AlignCenter)
        self.gift_label.setFixedWidth(500)
        gif.start()
        lay.addWidget(self.gift_label,1,1)
        self.lcd = QtWidgets.QLCDNumber(self)
        self.lcd.setFont(QtGui.QFont("Square Sans Serif_7",20))
        self.show_time()
        self.timer = QtCore.QTimer(self)
        self.timer.timeout.connect(self.show_time)
        self.timer.start(10000)
        lay.addWidget(self.lcd,2,1)
        self.label = QtWidgets.QLabel(self)
        self.label.setText("Iran - Tehran 🇮🇷")
        self.label.setFont(QtGui.QFont("Arial",20))
        self.label.setGeometry(200,30,10,10)
        lay.addWidget(self.label,3,1)
        self.currency_tabel = self.Table()
        lay.addWidget(self.currency_tabel, 0,1)
        lay.setMenuBar(self.create_menu_bar())
    def Table(self):
        table = QtWidgets.QTableWidget()
        table.setRowCount(7)
        table.setColumnCount(2)
        table.setItem(0,0,QtWidgets.QTableWidgetItem("Currency"))
        table.setItem(0,1,QtWidgets.QTableWidgetItem("Price (Per Toman)"))
        
        currency = [
            ["Dollar 💲", api.get_currency_data("usd_sell")[0]], 
            ["Euro 🇪🇺", api.get_currency_data("eur_hav")[0]],
            ["Pound 💷", api.get_currency_data("gbp_hav")[0]],
            ["Ether ", api.get_currency_data("eth")[0]],
            ["Bitcoin ₿", api.get_currency_data("btc")[0]],
            ["Coin 🪙", api.get_currency_data("bahar")[0]]
        ]

        for i in range(2):
            table.setColumnWidth(i,298)
        for j in range(7):
            table.setRowHeight(j,30)
        for i,cur in enumerate(currency):
            for j, item in enumerate(cur):
                table.setItem(i+1,j,QtWidgets.QTableWidgetItem(item))
        table.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)
        return table

    
    def show_time(self):
        current_time = QtCore.QTime.currentTime()
        show_time = current_time.toString("hh:mm")
        self.lcd.display(show_time)


    def connect_log_in(self):
        Swindow.show()
        Swindow.Sign_up_button.clicked.connect(Lwindow.show)
        if Swindow.t == True:
            self.user_email = Swindow.user_email.text()
            
            self.plotwindow = plots.income_plot(self.user_email)
            self.ex_plotwindow = plots.expenses_plot(self.user_email)
            
            self.plot_button.clicked.connect(self.plotwindow.show)
            self.plot_button1.clicked.connect(self.ex_plotwindow.show)
            self.user_label.setText(db.get_user_name(self.user_email))


    def show_dialog(self):
        selected_qdate = self.calender.selectedDate()
        record_date = selected_qdate.toPyDate()
        
        if win.exec_() == QtWidgets.QDialog.Accepted:
            income_text = win.income.text()
            expenses_text = win.expenses.text()
            
            if hasattr(self, 'user_email'):
                db.save_transaction(self.user_email, record_date, income_text, expenses_text)
            
            win.income.clear()
            win.expenses.clear()

    def create_menu_bar(self):
        self.menu_bar = QtWidgets.QMenuBar()
        self.user_label = QtWidgets.QLabel("")
        self.openWin2Action = QtWidgets.QAction('Log in', self)
        self.menu_bar.addAction(self.openWin2Action)
        self.openWin2Action.triggered.connect(self.connect_log_in)
        self.menu_bar.addAction(self.user_label.text())
        return self.menu_bar
    
class input_dialog(QtWidgets.QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Enter Values")
        self.setWindowIcon(QtGui.QIcon("profit.png"))
        self.setFixedSize(310,300)
        
        label = QtWidgets.QLabel("Please enter income and expenses of the \nday in rial.", self)
        
        self.lay = QtWidgets.QVBoxLayout()
        self.income = QtWidgets.QLineEdit()
        self.income.setPlaceholderText("Enter Income: ")
        self.expenses = QtWidgets.QLineEdit()
        self.expenses.setPlaceholderText("Enter Expenses: ")
        
        self.enter_button = QtWidgets.QPushButton("Enter")
        self.enter_button.clicked.connect(self.accept)
        
        self.intvalid = QtGui.QIntValidator()
        self.income.setValidator(self.intvalid)
        self.expenses.setValidator(self.intvalid)
        
        self.lay.addWidget(label)
        self.lay.addWidget(self.income)
        self.lay.addWidget(self.expenses)
        self.lay.addWidget(self.enter_button)
        self.setLayout(self.lay)

    def enter_button(self):  
        global income
        global expenses      
        income = self.income.text()
        expenses = self.expenses.text()
        if income and expenses:
            win.close()
        return True
    
app = QtWidgets.QApplication(sys.argv)
win = input_dialog()
window = Main()
window.show()   
Lwindow = dialogs.sign_up()
Swindow = dialogs.Log_in()
Swindow.Log_in_button.clicked.connect(Swindow.close)
sys.exit(app.exec_())