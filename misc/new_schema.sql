/* This is the SQL code for the schema creation of the cinema_booking_app
By Shreyas Anupindi */
/*remember to add on update constraint later if necessary:*/

drop database amaterasu;
create database amaterasu;

\c amaterasu

create table actor(
name varchar(40) primary key,
gender varchar(1),
dob date
);

create table director(
name varchar(40) primary key,
gender varchar(1),
dob date
);

create table movie(
title varchar(40) primary key,
running_time varchar(12),
critics_score numeric(2,1),
language varchar(12)
);

create table starring(
movie_title varchar(40),
actor_name varchar(40),
primary key(movie_title,actor_name),
foreign key(movie_title) references movie,
foreign key(actor_name) references actor
);

create table directed_by(
movie_title varchar(40),
director_name varchar(40),
primary key(movie_title),
foreign key(movie_title) references movie,
foreign key(director_name) references director
);

/*format for the movie*/
create table format(
format_id numeric(2,0) primary key,
category varchar(5)
);

create table shown_in(
movie_title varchar(40) primary key,
format_id numeric(2,0),
foreign key(movie_title) references movie,
foreign key(format_id) references format
);

create table show(
show_id numeric(2,0),
show_date date,
show_time varchar(10),
primary key(show_id)
);

create table screening(
show_id numeric(2,0),
movie_title varchar(40),
primary key(show_id),
foreign key(show_id) references show,
foreign key(movie_title) references movie
);
create table auditorium(
auditorium_number numeric(2,0),
primary key(auditorium_number)
);

create table seat(
row_num varchar(2),
col_num numeric(2,0),
price numeric(3,0),
primary key(row_num,col_num)
);

create table host_auditorium(
id numeric(2,0),
audi_number numeric(2,0),
row_num varchar(2),
col_num numeric(2,0),
seat_status varchar(10) default 'free',
primary key(id,audi_number,row_num,col_num),
foreign key(audi_number) references auditorium,
foreign key(row_num,col_num) references seat
);

create table show_details(
show_id numeric(2,0),
host_id numeric(2,0),
primary key(show_id),
foreign key(show_id) references show,
foreign key(host_id) references host_auditorium(id)
);

create table customer(
email varchar(40) primary key,
password varchar(30),
name varchar(40),
phone_number numeric(10,0),
balance numeric(6,2)
);
/*this is a 4-ary relationship */
create table booking(
cust_email varchar(40),
show_id numeric(2,0),
audi_number numeric(2,0),
seat_row varchar(2),
seat_col numeric(2,0),
booking_id numeric(6,0),
primary key(cust_email,show_id,audi_number,seat_row,seat_col),
foreign key(cust_email) references customer,
foreign key(show_id) references show,
foreign key(audi_number) references auditorium,
foreign key(seat_row,seat_col) references seat
);
