import bcrypt
from models import SessionLocal, User, Transaction
from datetime import date

def hash_password(password: str) -> str:
 
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')

def check_password(plain_password: str, hashed_password: str) -> bool:

    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))

def add_user(username, email, phone, password):

    db = SessionLocal()
    try:

        if db.query(User).filter(User.email == email).first():
            return False
            
        hashed_pw = hash_password(password)
        new_user = User(
            username=username, 
            email=email, 
            phone=phone, 
            password_hash=hashed_pw
        )
        db.add(new_user)
        db.commit()
        return True
    finally:
        db.close()

def check_email_password(email, password):

    db = SessionLocal()
    try:
        user = db.query(User).filter(User.email == email).first()
        if user and check_password(password, user.password_hash):
            return True
        return False
    finally:
        db.close()

def get_user_name(email):

    db = SessionLocal()
    try:
        user = db.query(User).filter(User.email == email).first()
        return user.username if user else None
    finally:
        db.close()

def save_transaction(email, record_date, income, expense):
 
    db = SessionLocal()
    try:
        user = db.query(User).filter(User.email == email).first()
        if not user:
            return False
            

        transaction = db.query(Transaction).filter(
            Transaction.user_id == user.id,
            Transaction.record_date == record_date
        ).first()

        income_val = float(income) if income else 0.0
        expense_val = float(expense) if expense else 0.0

        if transaction:
    
            if income: transaction.income = income_val
            if expense: transaction.expense = expense_val
        else:

            new_tx = Transaction(
                user_id=user.id,
                record_date=record_date,
                income=income_val,
                expense=expense_val
            )
            db.add(new_tx)
        
        db.commit()
        return True
    finally:
        db.close()