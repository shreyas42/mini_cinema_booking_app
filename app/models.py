# coding: utf-8
from sqlalchemy import Column, Date, ForeignKey, ForeignKeyConstraint, Integer, Numeric, String, Table, Time, text
from sqlalchemy.orm import relationship,backref
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.sql import and_,or_,not_
from app import db

Base = declarative_base()
metadata = Base.metadata


class Actor(Base):
    __tablename__ = 'actor'

    name = Column(String(40), primary_key=True)
    gender = Column(String(1), nullable=False)
    dob = Column(Date, nullable=False)

    movie = relationship('Movie', secondary='starring')


class Auditorium(Base):
    __tablename__ = 'auditorium'

    number = Column(Integer, primary_key=True)


class Booking(Base):
    __tablename__ = 'booking'
    __table_args__ = (
        ForeignKeyConstraint(['s_row_num', 's_col_num'], ['seat.row_num', 'seat.col_num']),
    )

    cust_email = Column(ForeignKey('customer.email'), primary_key=True, nullable=False)
    show_id = Column(ForeignKey('show.show_id'), primary_key=True, nullable=False)
    s_row_num = Column(String(1), primary_key=True, nullable=False)
    s_col_num = Column(Integer, primary_key=True, nullable=False)
    booking_id = Column(String(6), nullable=False)

    customer = relationship('Customer')
    seat = relationship('Seat')
    show = relationship('Show')


class Customer(Base):
    __tablename__ = 'customer'

    email = Column(String(30), primary_key=True)
    password = Column(String(10), nullable=False)
    name = Column(String(20), nullable=False)
    phone_number = Column(Numeric(10, 0), nullable=False)
    balance = Column(Integer, nullable=False)

t_directed_by = Table(
    'directed_by', metadata,
    Column('movie_title', ForeignKey('movie.title'), primary_key=True),
    Column('director_name', ForeignKey('director.name'), nullable=False)
)

#class User(db.Model):
#    __tablename__ = 'user'
#      id = db.Column(Integer,primary_key = True)
#    cust_email = db.Column(String(30),ForeignKey('customer.email'))
#    customer = db.relationship("customer",backref="user",uselist=False)

class Director(Base):
    __tablename__ = 'director'

    name = Column(String(40), primary_key=True)
    gender = Column(String(1), nullable=False)
    dob = Column(Date, nullable=False)

    movie = relationship('Movie', secondary='directed_by')


class Format(Base):
    __tablename__ = 'format'

    format_id = Column(String(3), primary_key=True)
    category = Column(String(10), nullable=False)

    movie = relationship('Movie', secondary='shown_in')


class Movie(Base):
    __tablename__ = 'movie'

    title = Column(String(40), primary_key=True)
    running_time = Column(Integer, nullable=False)
    critics_score = Column(Numeric(3, 1), nullable=False)
    language = Column(String(9), nullable=False)

    shows = relationship('Show', secondary='screening')


t_screening = Table(
    'screening', metadata,
    Column('show_id', ForeignKey('show.show_id'), primary_key=True),
    Column('movie_title', ForeignKey('movie.title'), nullable=False)
)


class Seat(Base):
    __tablename__ = 'seat'

    row_num = Column(String(1), primary_key=True, nullable=False)
    col_num = Column(Integer, primary_key=True, nullable=False)
    price = Column(Integer, nullable=False)


class Show(Base):
    __tablename__ = 'show'

    show_id = Column(String(10), primary_key=True)
    show_date = Column(Date, nullable=False)
    show_time = Column(Time, nullable=False)


class ShowDetail(Base):
    __tablename__ = 'show_details'
    __table_args__ = (
        ForeignKeyConstraint(['s_row_num', 's_col_num'], ['seat.row_num', 'seat.col_num']),
    )

    show_id = Column(ForeignKey('show.show_id'), primary_key=True, nullable=False)
    audi_number = Column(ForeignKey('auditorium.number'), primary_key=True, nullable=False)
    s_row_num = Column(String(1), primary_key=True, nullable=False)
    s_col_num = Column(Integer, primary_key=True, nullable=False)
    s_status = Column(String(1), nullable=False)

    auditorium = relationship('Auditorium')
    seat = relationship('Seat')
    show = relationship('Show')


t_shown_in = Table(
    'shown_in', metadata,
    Column('movie_title', ForeignKey('movie.title'), primary_key=True),
    Column('format_id', ForeignKey('format.format_id'), nullable=False)
)


t_starring = Table(
    'starring', metadata,
    Column('movie_title', ForeignKey('movie.title'), primary_key=True, nullable=False),
    Column('actor_name', ForeignKey('actor.name'), primary_key=True, nullable=False)
)

'''
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = Column(String(30), nullable=False)
    password = Column(String(10), nullable=False)
    name = Column(String(20), nullable=False)
    phone_number = Column(Numeric(10, 0), nullable=False)
    balance = Column(Integer, nullable=False)

    @property
    def is_authenticated(self):
        return True

    @property
    def is_active(self):
        return True

    @property
    def is_anonymous(self):
        return False

    def get_id(self):
        try:
            return unicode(self.id)  # python 2
        except NameError:
            return str(self.id)  # python 3

    def __repr__(self):
        return '<User %r>' % (self.email)
'''