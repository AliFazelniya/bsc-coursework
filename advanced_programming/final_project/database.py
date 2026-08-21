import bcrypt
from models import SessionLocal, User, Transaction

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