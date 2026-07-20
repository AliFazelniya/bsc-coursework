import pickle
import os
# import Dialogs
class Database():
    def __init__(self, username, email, phone, password):
        self.username = username
        self.email = email
        self.phone = phone
        self.password = password
    def return_dic(self):
        dic = {"username": self.username,
              "email": self.email,
              "Phone number": self.phone,
              "password": self.password}
        return dic

if not os.path.isfile('Database.bin'):
    with open("Database.bin", "wb") as datn:
        pickle.dump([], datn)

def add_user(username, email, phone, password):
    user = Database(username, email, phone, password)
    with open("Database.bin", "rb") as dat1:
        dicts = pickle.load(dat1)
    with open("Database.bin", "wb") as dat:
        dicts.append(user.return_dic())
        pickle.dump(dicts, dat)

def emails():
    emails_list = []
    dat = open("Database.bin", "rb")
    dicts = pickle.load(dat)
    dat.close()
    for i in dicts:
        emails_list.append(i["email"])
    # for i in emails_list:
        # create_user_directory(i)
    return emails_list

def passwords():
    passwords_list = []
    dat = open("Database.bin", "rb")
    dicts = pickle.load(dat)
    dat.close()
    for i in dicts:
        passwords_list.append(i["password"])
    return passwords_list

def user_names():
    usernames_list = []

    dat = open("Database.bin", "rb")
    dicts = pickle.load(dat)
    dat.close()
    for i in dicts:
        usernames_list.append(i["username"])
    return usernames_list

def get_user_name(email):
    email_index = emails().index(email)
    username  = user_names()[email_index]
    return username

def check_email_password(email,password):
    email_index = emails().index(email)
    if password == passwords()[email_index]:
        return True
    
def create_user_directory(email):
    newpath = f"users/{email}" 
    if not os.path.exists(newpath):
        os.makedirs(newpath)
        
def add_year(path, year):
    if  not os.path.exists(f"{path}/{year}"):
        year_path = f"{path}/{year}"
        os.mkdir(year_path)
        
def change_income(path, month, day, income):
    if not os.path.isfile(f"{path}/{month}-income.bin"):
        data = []
        for i in range(1,32):
            data.append(i)
        with open(f"{path}/{month}-income.bin","wb") as f:
            data[int(day)-1] = int(income)
            pickle.dump(data, f)
    else:
        with open(f"{path}/{month}-income.bin","rb") as f:
            data = pickle.load(f)
        with open(f"{path}/{month}-income.bin","wb") as f:
            data[int(day)-1] = int(income)
            pickle.dump(data, f)

def change_expenses(path, month, day, expenses):
    if not os.path.isfile(f"{path}/{month}-expenses.bin"):
        data = []
        for i in range(1,32):
            data.append(i)
        with open(f"{path}/{month}-expenses.bin","wb") as f:
            data[int(day)-1] = int(expenses)
            pickle.dump(data, f)
    else:
        with open(f"{path}/{month}-expenses.bin","rb") as f:
            data = pickle.load(f)
        with open(f"{path}/{month}-expenses.bin","wb") as f:
            data[int(day)-1] = int(expenses)
            pickle.dump(data, f)