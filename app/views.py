from app import app,db
from flask import render_template,flash,redirect,session,url_for,request
from .models import *
import json
#from .forms import LoginForm
@app.route('/')
@app.route('/index')
def index():
	if not session.get('logged_in'):
		return render_template('login.html')
	else:
		myusers = db.session.query(Movie).all()
		return render_template('index.html',movies = myusers)

def row2dict(row):
	d={}
	for column in row.__table__.columns:
		d[column.name] = str(getattr(row,column.name))
	return d

@app.route('/aboutus')
def aboutus():
	return render_template('aboutus.html')

@app.route('/description')
def description():
	return render_template('description.html')

@app.route('/login',methods=['POST'])
def login():
	EMAIL = str(request.form['email'])
	PASSWORD = str(request.form['password'])
	check = db.session.query(Customer).filter(Customer.email.in_([EMAIL]),Customer.password.in_([PASSWORD]))
	result = check.first()
	if result:
		session['logged_in'] = True
		session['user'] = str(db.session.query(Customer.name).filter(Customer.email==EMAIL).one()).strip("('),")
		return index()
	else:
		flash('Wrong email or password entered!')
		return index()

@app.route('/logout')
def logout():
	session['logged_in'] = False
	session['user'] = None
	return index()

@app.route('/shows')
def shows():
	m_title = request.args.get('title',None)
#	shows = db.session.query(t_screening.c.show_id).filter(t_screening.c.movie_title == m_title).all()
#	for show in shows:
#		tmp = db.session.query(Show.show_date,Show.show_time).filter_by(show_id = show.show_id).one()
#		show_details.append(str(tmp))
	shows = db.session.query(t_screening).filter(t_screening.c.movie_title==m_title).all()
	show_details = []
	for show in shows:
		show_details.append(db.session.query(Show).filter(Show.show_id==show[0]).one())
		#print(show_details)
	return render_template('show.html',show_details= show_details,movie_name=m_title,count = len(show_details))

@app.route('/seat_selection')
def seat_selection():
	s_id = request.args.get('s_id',None)
	m_title = db.session.query(t_screening).filter(t_screening.c.show_id==s_id).one()
#	format_id = db.session.query(t_shown_in).filter(t_shown_in.c.movie_title==m_title[1]).one()
#	form = db.session.query(Format.category).filter(Format.format_id==format_id).one()
	s_details = db.session.query(Show.show_date,Show.show_time).filter(Show.show_id==s_id).one()
	audi_no = db.session.query(ShowDetail.audi_number).filter(ShowDetail.show_id==s_id).distinct()
	seats = db.session.query(ShowDetail.s_row_num,ShowDetail.s_col_num).filter(and_(ShowDetail.show_id==s_id,ShowDetail.s_status == 'A')).all()
	return render_template('seat_selection.html',movie_name = m_title[1],s_date = s_details[0],s_time = s_details[1],audi = str(audi_no[0]).strip('(),'),seats = seats)	
	

