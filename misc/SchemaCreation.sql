/* This is the SQL code for the schema creation of the cinema_booking_app
By Shreyas Anupindi */
/*remember to add on update constraint later if necessary:*/

drop database amaterasu;
create database amaterasu;

\c amaterasu

create table actor(name varchar(40) primary key,
rating numeric(2,2)
);


create table director(name varchar(40) primary key,
count_movies numeric(3,0)
);


create table movie(title varchar(40) primary key,
running_time varchar(12),
critics_score numeric(2,2),
language varchar(12)
);


create table starring(movie_title varchar(40),
actor_name varchar(40),
primary key(movie_title,actor_name),
foreign key(movie_title) references movie on delete cascade,
foreign key(actor_name) references actor on delete set null
);

create table directed_by(movie_title varchar(40),
director_name varchar(40),
primary key(movie_title,director_name),
foreign key(movie_title) references movie on delete cascade,
foreign key(director_name) references director on delete set null
);

/*format for the movie*/
create table format(movie_title varchar(40) primary key,
category varchar(5),
fps numeric(3,1),
foreign key(movie_title) references movie on delete cascade
);

/*shows */
create table show(show_id varchar(10),
show_date date,
show_time time,
primary key(show_id,show_date,show_time)
);

/*Screening of movies */
create table screening(show_id varchar(10),
s_date date,
s_time time,
movie_title varchar(40),
primary key(show_id,s_date,s_time),
foreign key(show_id,s_date,s_time) references show on delete cascade on update cascade,
foreign key(movie_title) references movie on delete cascade on update cascade
);

/*Auditorium for the multiplex */
create table auditorium(number numeric(2,0) primary key
);

/*hosting relationship b/w show and auditorium */
create table hosts(audi_number numeric(2,0),
s_id varchar(10),
s_date date,
s_time time,
primary key(audi_number,s_id,s_date,s_time),
foreign key(audi_number) references auditorium on delete cascade on update cascade,
foreign key(s_id,s_date,s_time) references show on delete cascade on update cascade
);

/*customer entity*/
create table customer(email_id varchar(40),
name varchar(40),
phone_number varchar(10),
password varchar(20),
wallet numeric(6,2),
primary key(email_id)
);

/*booking entity */
create table booking(booking_id varchar(10) primary key);

/*books relationship */
create table books(booking_id varchar(10),
cust_email varchar(40),
primary key(booking_id),
foreign key(booking_id) references booking on delete cascade,
foreign key(cust_email) references customer on delete set null
);

/*seat entity*/
create table seat(row_number varchar(2),
col_number numeric(2,0),
available boolean default True,
price numeric(3,0),
primary key(row_number,col_number)
);

/*reserves relationship */
create table reserves(row_num varchar(2),
col_num numeric(2,0),
booking_id varchar(10),
primary key(row_num,col_num),
foreign key(row_num,col_num) references seat on delete cascade,
foreign key(booking_id) references booking on delete cascade
);

/*contains relationship */
create table contains(audi_number numeric(2,0),
row_num varchar(2),
col_num numeric(2,0),
primary key(audi_number,row_num,col_num),
foreign key(audi_number) references auditorium on delete cascade,
foreign key(row_num,col_num) references seat on delete cascade
);

/*permits to relationship */
create table permits_to(booking_id varchar(10) primary key,
s_id varchar(10),
s_date date,
s_time time,
foreign key(booking_id) references booking on delete cascade,
foreign key(s_id,s_date,s_time) references show on delete cascade
);
