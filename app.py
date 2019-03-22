# constrain to python 2.7 or install bottle-cork with pip install --use-wheel --no-index --find-links=https://github.com/sfbahr/PyCrypto-Wheels/raw/master/pycrypto-2.6.1-cp35-none-win32.whl pycrypto
import bottle
from bottle import run, route, template, static_file, request, hook, redirect
from beaker.middleware import SessionMiddleware
from functools import wraps
from bottle.ext import sqlalchemy
from sqlalchemy import create_engine, Column, Integer, Sequence, String, Text
from sqlalchemy.ext.declarative import declarative_base
from uuid import uuid4
import random

Base = declarative_base()
engine = create_engine('mysql+pymysql://username:password@host/dbname') #insert mysql connection string here


app = bottle.app()
plugin = sqlalchemy.Plugin(engine, keyword='db')
app.install(plugin)
session_opts = {
    'session.cookie_expires': True,
    'session.encrypt_key': 'kjkfkjvnjkkjiuitiutiuueoieoieffoisjvnvl',
    'session.httponly': True,
    'session.timeout': 3600 * 24,
    'session.type': 'cookie',
    'session.validate_key': True,
}
app = SessionMiddleware(app, session_opts)


#class for db table
class user(Base):
    __tablename__='user'
    id = Column(Integer,primary_key=True)
    name = Column(String(50))
    username = Column(String(50))
    password = Column(String(50))

class article(Base):
    __tablename__='article'
    id = Column(Integer, primary_key=True)
    title = Column(String(200))
    body = Column(Text())
    author = Column(String(25))

@hook('before_request')
def setup_request():
    request.session = request.environ['beaker.session']

#login required decorator
def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'username' in request.session:
            return f(*args, **kwargs)
        else:
            redirect('/login')
    return wrap


# serving static files
@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='./static')

@route('/')
def index(db):
    result = db.query(article)
    articles = []
    for i in result:
        articles.append({'title': i.title, 'body': i.body, 'author': i.author,'id': i.id })

    if 'username' in request.session:
        current_username = request.session['username']
        return template('index', username=current_username, articles = articles)
    else:
        return template('index_open', articles=articles)


@route('/register')
def register():
    return template('register')

@route('/register', method='POST')
def do_register(db):
    name = request.forms.get('name')
    username = request.forms.get('username')
    password = request.forms.get('password')
    #query to make sure no username exists to avoid duplicates
    result = db.query(user).filter(user.username==username).first()
    if result == None:
        new_user = user(name=name, username=username, password=password)
        db.add(new_user)
        db.commit()
        request.session['username'] = username
        request.session.save()
        redirect('/')
    else:
        redirect('/register')

#admin adds writers
@route('/add_writer', method='POST')
@login_required
def add_writer(db):
    name1 = request.session['username']
    if name1 != 'reed':
        redirect('/')

    name = request.forms.get('name')
    username = request.forms.get('username')
    password = request.forms.get('password')
    #query to make sure no username exists
    result = db.query(user).filter(user.username==username).first()
    if result == None:
        new_user = user(name=name, username=username, password=password)
        db.add(new_user)
        db.commit()
        return template('notification', message='New writer added successfully', username=name1)
    else:
        return template('notification', message='Username already in use.', username=name1)

@route('/login')
def login():
    return template('login')

@route('/login', method='POST')
def do_login(db):
    username = request.forms.get('username')
    password = request.forms.get('password')
    result = db.query(user).filter(user.username==username).first()
    if result == None:
        redirect('/login')
    if result.password == password:
        request.session['username'] = username
        request.session.save()
        redirect('/')
    else:
        redirect('/login')


@route('/admin')
@login_required
def admin():
    name = request.session['username']
    if name != 'reed':
        redirect('/')

    return template('admin', name=name)

@route('/view/article/<id:int>')
def view_article(id, db):
    result = db.query(article).filter(article.id==id).first()
    return template('view_article', article=result)

#route for creating new articles
@route('/new/article')
@login_required
def new_article():
    current_username = request.session['username']
    return template('create_new', username=current_username)

@route('/new/article', method='POST')
@login_required
def add_new_article(db):
    title = request.forms.get('title')
    body = request.forms.get('body')
    author = request.session['username']
    new_article = article(title=title, body=body, author=author)
    db.add(new_article)
    db.commit()
    redirect('/')

#edit article
@route('/edit/article/<id:int>')
@login_required
def edit_article(id, db):
    current_username = request.session['username']
    to_edit = db.query(article).filter(article.id==id).first()
    return template('edit_article', username=current_username, article=to_edit)

@route('/edit/article/<id:int>', method='POST')
@login_required
def save_edited(db, id):
    title = request.forms.get('title')
    body = request.forms.get('body')
    author = request.session['username']
    to_edit = db.query(article).filter(article.id==id).first()
    to_edit.title = title
    to_edit.body = body
    to_edit.author = author
    db.commit()
    redirect('/')



@route('/delete/article/<id:int>')
@login_required
def delete_article(id, db):
    to_delete = db.query(article).filter(article.id==id).first()
    db.delete(to_delete)
    db.commit()
    redirect('/')

@route('/logout')
def logout():
    if 'username' in request.session:
        request.session.delete()
        redirect('/login')

def main():
    bottle.run(app=app, reloader=False)

if __name__ == "__main__":
    main()
