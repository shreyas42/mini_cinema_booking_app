from app import app,db
from flask import render_template,flash,redirect,session,url_for,request
from .models import *
import json
import random
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
		session['email'] = EMAIL
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
	session['movie_name'] = str(m_title)
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
	session['showid'] = s_id
	m_title = db.session.query(t_screening).filter(t_screening.c.show_id==s_id).one()
	s_details = db.session.query(Show.show_date,Show.show_time).filter(Show.show_id==s_id).one()
	session['showdate'] = str(s_details[0])
	session['showtime'] = str(s_details[1])
	audi_no = db.session.query(ShowDetail.audi_number).filter(ShowDetail.show_id==s_id).distinct()
	session['audi_no'] = int(str(audi_no[0]).strip("(),"))
	seats = db.session.query(ShowDetail.s_row_num,ShowDetail.s_col_num).filter(and_(ShowDetail.show_id==s_id,ShowDetail.s_status == 'A')).all()
	form = db.session.query(t_shown_in.c.format_id).filter(t_shown_in.c.movie_title==m_title[1]).one()
	format = db.session.query(Format.category).filter(Format.format_id==form).one()
	return render_template('seat_selection.html',movie_name = m_title[1],s_date = s_details[0],s_time = s_details[1],audi = str(audi_no[0]).strip('(),'),seats = seats,format = str(format).strip("'(),"))	

@app.route('/confirmation',methods=['POST'])
def confirmation():
	booking_status = False
	seats_selected = request.form.getlist('check',None)
#print(seats_selected)
#	print(session['user'])
#	print(session['movie_name'])
#	print(session['showdate'])
#	print(session['showtime'])
#	print(session['audi_no'])
	asda = session['user'][0:3].upper()
	booking_id = asda + str(random.randint(2,1000)).zfill(2)
	check = db.session.query(Booking).filter(Booking.booking_id.in_([booking_id]))
	result = check.first()
	while result:
		booking_id = asda + str(random.randint(2,1000)).zfill(2)
		check = db.session.query(Booking).filter(Booking.booking_id.in_([booking_id]))
		result = check.first()	
#	print(booking_id)
	seat_details = []
	for seat in seats_selected:
		seat_details.append((seat[0:1],int(seat[1:])))
#	print(seats_selected)
	prices = []
	for seat in seat_details:
		price = db.session.query(Seat.price).filter(and_(Seat.row_num==seat[0],Seat.col_num==seat[1])).one()
		prices.append(int(str(price).strip("(),")))
#	print(prices)
	total_cost = sum(prices)
	user_balance = int(str(db.session.query(Customer.balance).filter(Customer.email==session['email']).one()).strip("(),"))

#	print(user_balance)
	if total_cost > user_balance:
		message = 'Insufficient Funds'
	else:
		booking_status = True
	if booking_status:
		user = db.session.query(Customer).filter(Customer.email==session['email']).one()
		user.balance -=total_cost
		for seat in seat_details:
			listing = db.session.query(ShowDetail).filter(and_(ShowDetail.show_id==session['showid'],ShowDetail.s_row_num==seat[0],ShowDetail.s_col_num==seat[1])).one()
			listing.s_status = 'B'
		db.session.commit()
		message = 'Booking Successful!'
	return render_template('confirmation.html',movie = session['movie_name'],seats_selected = seats_selected,date = session['showdate'],time = session['showtime'],auditorium=session['audi_no'],booking_id = booking_id,message = message,booking_status=booking_status)