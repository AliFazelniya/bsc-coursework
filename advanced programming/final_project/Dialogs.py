import typing
from PyQt5 import QtWidgets, QtCore, QtGui
import sys
from PyQt5.QtWidgets import QWidget
import DateBase as db
import re
import time
# import Main
class Log_in(QtWidgets.QDialog):
    def __init__(self):
        super().__init__()
        self.t = False
        self.setWindowTitle("Log in")
        self.setFixedSize(500,500)
        self.lay = QtWidgets.QVBoxLayout()
        self.user_email = QtWidgets.QLineEdit(self)
        self.user_email.setPlaceholderText("Enter Email:")
        self.user_pass = QtWidgets.QLineEdit(self)
        self.user_pass.setPlaceholderText("Enter Password:")
        self.user_pass.setEchoMode(QtWidgets.QLineEdit.EchoMode.Password)
        label1 = QtWidgets.QLabel(self)
        label1.setText("Please Enter Email and Password of Your account.")
        label2 = QtWidgets.QLabel(self)
        label2.setText("Don't have an acount? Please sign up first!")
        label3 = QtWidgets.QLabel("", self)
        label3.setPixmap(QtGui.QPixmap("profit.png"))
        label3.setGeometry(210,10,64,64)
        self.label4 = QtWidgets.QLabel(self)
        self.label4.setText("Economy Manager")
        self.label4.setGeometry(185,60,130,50)
        self.lay.addSpacing(100)
        self.lay.addWidget(label1)
        self.lay.addWidget(self.user_email)
        self.lay.addWidget(self.user_pass)
        self.Log_in_button = QtWidgets.QPushButton("Log in")
        self.Sign_up_button = QtWidgets.QPushButton("Sign up")
        self.lay.addWidget(self.Log_in_button)
        self.lay.addWidget(label2)
        self.lay.addWidget(self.Sign_up_button)
        self.setLayout(self.lay)
        self.Log_in_button.clicked.connect(self.sign_in_data_check)
    def sign_in_data_check(self):
        self.t = False
        self.user_email_text = self.user_email.text()
        if not self.user_email_text in db.emails():
            self.email_error_message()
        elif not db.check_email_password(self.user_email_text, self.user_pass.text()):
            self.password_error_message()
        elif self.user_email_text in db.emails() and db.check_email_password(self.user_email_text, self.user_pass.text()): 
            self.t = True
    def email_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("Invalid Email")
        error_box.setText("There is no user with this email. please enter a valid email.")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()
    def password_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("Wrong Password")
        error_box.setText("The entered passwrod is wrong, Please enter a correct password.")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()
class sign_up(QtWidgets.QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Sign up")
        self.setFixedSize(500,500)
        self.lay = QtWidgets.QVBoxLayout()
        self.user_name = QtWidgets.QLineEdit()
        self.user_name.setPlaceholderText("Enter User name: ")
        self.email = QtWidgets.QLineEdit()
        self.email.setPlaceholderText("Enter Email: ")
        self.phone = QtWidgets.QLineEdit()
        self.phone.setPlaceholderText("Enter your number: ")
        self.password1 = QtWidgets.QLineEdit()
        self.password1.setPlaceholderText("Enter a password: ")
        self.password2 = QtWidgets.QLineEdit()
        self.password2.setPlaceholderText("Enter Password again: ")
        self.password1.setEchoMode(QtWidgets.QLineEdit.EchoMode.Password)
        self.password2.setEchoMode(QtWidgets.QLineEdit.EchoMode.Password)
        label1 = QtWidgets.QLabel("\n\n\n\n\n\n\n\nWellcome! \nThis app is your assistance to manage your income and expenses.\nAnd it can also help you to have a better economic life.\nTo Create an acount, Please enter your Information.")
        label3 = QtWidgets.QLabel("", self)
        label3.setPixmap(QtGui.QPixmap("profit.png"))
        label3.setGeometry(210,10,64,64)
        self.label4 = QtWidgets.QLabel(self)
        self.label4.setText("Economy Manager")
        self.label4.setGeometry(185,60,130,50)
        self.label5 = QtWidgets.QLabel("", self)
        self.Creat_button = QtWidgets.QPushButton("Create")
        self.lay.addWidget(label1)
        self.lay.addWidget(self.user_name)
        self.lay.addWidget(self.email)
        self.lay.addWidget(self.phone)
        self.lay.addWidget(self.password1)
        self.lay.addWidget(self.password2)
        self.lay.addWidget(self.Creat_button)
        self.lay.addWidget(self.label5)
        self.setLayout(self.lay)
        self.intvalid = QtGui.QIntValidator()
        self.phone.setValidator(self.intvalid)
        self.Creat_button.clicked.connect(self.sign_up_data_check)
    def sign_up_data_check(self):
        if not self.user_name.text():
            self.user_name_error_message()
        elif not self.phone.text():
            self.phone_error_message()
        elif not re.search(".*@gmail.com$", self.email.text()):
            self.email_error_message()
        elif self.password1.text() != self.password2.text():
            self.password_error_message()
        else:
            db.add_user(self.user_name.text(), self.email.text(), self.phone.text(), self.password2.text())
            self.label5.setText("Congratulation! You signed up!")
            time.sleep(3)
            db.create_user_directory(self.email.text())
            sign_up.close()
            return True
    def email_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("Invalid Email")
        error_box.setText("The entered email is invalid! Please enter a valid email.")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()
    def password_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("Invalid Password")
        error_box.setText("The Second entered password is not as same as the first entered password. ")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()
    def user_name_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("No Username")
        error_box.setText("You didn't enter a username, Please enter a username.")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()
    def phone_error_message(self):
        error_box = QtWidgets.QMessageBox()
        error_box.setWindowTitle("No Phone Number")
        error_box.setText("You didn't enter a Phone number, Please enter a phone number.")
        error_box.setIcon(QtWidgets.QMessageBox.Icon.Warning)
        error_box.setStandardButtons(QtWidgets.QMessageBox.Ok)
        error_box.exec()  
# if __name__ == "__main__":
    # app = QtWidgets.QApplication(sys.argv)
    # window = Log_in()
    # sys.exit(app.exec_())