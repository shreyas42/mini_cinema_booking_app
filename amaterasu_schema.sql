
\c amaterasu

CREATE TABLE actor(
   name   VARCHAR(40) NOT NULL PRIMARY KEY
  ,gender VARCHAR(1) NOT NULL
  ,dob    DATE  NOT NULL
);

CREATE TABLE director(
   name   VARCHAR(40) NOT NULL PRIMARY KEY
  ,gender VARCHAR(1) NOT NULL
  ,dob   DATE  NOT NULL
);

CREATE TABLE movie(
   title         VARCHAR(40) NOT NULL PRIMARY KEY
  ,running_time  INTEGER  NOT NULL
  ,critics_score NUMERIC(3,1) NOT NULL
  ,language      VARCHAR(9) NOT NULL
);

CREATE TABLE starring(
   movie_title VARCHAR(40) NOT NULL 
  ,actor_name  VARCHAR(40) NOT NULL
  ,PRIMARY KEY(movie_title,actor_name)
  ,FOREIGN KEY(movie_title) references movie
  ,FOREIGN KEY(actor_name) references actor
);


CREATE TABLE directed_by(
   movie_title   VARCHAR(40) NOT NULL PRIMARY KEY
  ,director_name VARCHAR(40) NOT NULL
  ,FOREIGN KEY(movie_title) references movie
  ,FOREIGN KEY(director_name) references director
);

CREATE TABLE format(
   format_id VARCHAR(3) NOT NULL PRIMARY KEY
  ,category  VARCHAR(10) NOT NULL
);

CREATE TABLE shown_in(
   movie_title VARCHAR(40) NOT NULL PRIMARY KEY
  ,format_id   VARCHAR(3) NOT NULL
  ,FOREIGN KEY(movie_title) references movie
  ,FOREIGN KEY(format_id) references format
);

CREATE TABLE show(
   show_id   VARCHAR(10) NOT NULL PRIMARY KEY
  ,show_date DATE  NOT NULL
  ,show_time TIME NOT NULL
);

CREATE TABLE screening(
   show_id     VARCHAR(6) NOT NULL PRIMARY KEY
  ,movie_title VARCHAR(28) NOT NULL
  ,FOREIGN KEY(show_id) references show
  ,FOREIGN KEY(movie_title) references movie
);

CREATE TABLE auditorium(
   number INTEGER  NOT NULL PRIMARY KEY 
);

CREATE TABLE seat(
   row_num VARCHAR(1) NOT NULL
  ,col_num INTEGER  NOT NULL
  ,price   INTEGER  NOT NULL
  ,PRIMARY KEY(row_num,col_num)
);

CREATE TABLE customer(
   email        VARCHAR(30) NOT NULL PRIMARY KEY
  ,password     VARCHAR(10) NOT NULL
  ,name         VARCHAR(20) NOT NULL
  ,phone_number NUMERIC(10,0)  NOT NULL
  ,balance      INTEGER  NOT NULL
);

CREATE TABLE show_details(
	show_id VARCHAR(10) NOT NULL
   ,audi_number INTEGER NOT NULL
   ,s_row_num VARCHAR(1) NOT NULL
   ,s_col_num INTEGER NOT NULL
   ,s_status VARCHAR(1) NOT NULL
   ,PRIMARY KEY(show_id,audi_number,s_row_num,s_col_num)
   ,FOREIGN KEY(show_id) references show
   ,FOREIGN KEY(audi_number) references auditorium
   ,FOREIGN KEY(s_row_num,s_col_num) references seat
);

CREATE TABLE BOOKING(
	cust_email VARCHAR(30) NOT NULL 
   ,show_id VARCHAR(10) NOT NULL
   ,s_row_num VARCHAR(1) NOT NULL
   ,s_col_num INTEGER NOT NULL
   ,booking_id VARCHAR(6) NOT NULL
   ,PRIMARY KEY(cust_email,show_id,s_row_num,s_col_num)
   ,FOREIGN KEY(cust_email) references customer
   ,FOREIGN KEY(show_id) references show
   ,FOREIGN KEY(s_row_num,s_col_num) references seat
);



























/*Insertion statements 
INSERT INTO actor(name,gender,dob) VALUES ('Mihaly Vig','F','1995-07-04');
INSERT INTO actor(name,gender,dob) VALUES ('Putyi Horvath','M','1987-11-12');
INSERT INTO actor(name,gender,dob) VALUES ('Laszlo Lugossy','F','1994-03-27');
INSERT INTO actor(name,gender,dob) VALUES ('Haley Joel Osment','M','1933-01-16');
INSERT INTO actor(name,gender,dob) VALUES ('Jude Law','M','1939-09-23');
INSERT INTO actor(name,gender,dob) VALUES ('Frances O’Connor','F','1945-04-12');
INSERT INTO actor(name,gender,dob) VALUES ('Tilda Swinton','F','1968-12-29');
INSERT INTO actor(name,gender,dob) VALUES ('Gabriele Ferzetti','M','1948-10-03');
INSERT INTO actor(name,gender,dob) VALUES ('Marisa Berenson','F','1943-06-08');
INSERT INTO actor(name,gender,dob) VALUES ('Chris Evans','M','1994-11-17');
INSERT INTO actor(name,gender,dob) VALUES ('Song Kang-ho','M','1961-04-01');
INSERT INTO actor(name,gender,dob) VALUES ('Jamie Bell','M','1992-02-08');
INSERT INTO actor(name,gender,dob) VALUES ('Eric Bana','M','2001-01-07');
INSERT INTO actor(name,gender,dob) VALUES ('Daniel Craig','M','1949-04-10');
INSERT INTO actor(name,gender,dob) VALUES ('Ciaran Hinds','M','1971-01-06');
INSERT INTO actor(name,gender,dob) VALUES ('Tom Hanks','M','1992-03-31');
INSERT INTO actor(name,gender,dob) VALUES ('Paul Newman','M','1977-03-08');
INSERT INTO actor(name,gender,dob) VALUES ('Leonardo DiCaprio','M','1995-09-17');
INSERT INTO actor(name,gender,dob) VALUES ('Javier Bardem','M','1960-05-31');
INSERT INTO actor(name,gender,dob) VALUES ('Judi Dench','F','1974-12-07');
INSERT INTO actor(name,gender,dob) VALUES ('Ken Watanabe','M','1963-01-16');
INSERT INTO actor(name,gender,dob) VALUES ('Marion Cotillard','F','1957-11-12');
INSERT INTO actor(name,gender,dob) VALUES ('Ellen Pdob','F','1984-03-27');
INSERT INTO actor(name,gender,dob) VALUES ('Joseph Gordon-Levitt','M','1983-01-16');
INSERT INTO actor(name,gender,dob) VALUES ('Tom Hardy','M','1979-09-23');
INSERT INTO actor(name,gender,dob) VALUES ('Cillian Murphy','M','1955-04-12');
INSERT INTO actor(name,gender,dob) VALUES ('Heloise Godet','F','1998-12-29');
INSERT INTO actor(name,gender,dob) VALUES ('Kamel Abdeli','M','1968-10-03');
INSERT INTO actor(name,gender,dob) VALUES ('Richard Chevallier','M','1973-06-08');
INSERT INTO actor(name,gender,dob) VALUES ('Zoe Bruneau','F','1984-11-17');
INSERT INTO actor(name,gender,dob) VALUES ('Andy Serkis','M','1961-06-01');
INSERT INTO actor(name,gender,dob) VALUES ('Nick Frost','M','1992-12-08');
INSERT INTO actor(name,gender,dob) VALUES ('Simon Pegg','M','2001-11-07');
INSERT INTO actor(name,gender,dob) VALUES ('Charlize Theron','F','1949-04-10');
INSERT INTO actor(name,gender,dob) VALUES ('Nicholas Hoult','M','1971-01-30');


INSERT INTO director(name,gender,dob) VALUES ('Name','M','1935-06-25');
INSERT INTO director(name,gender,dob) VALUES ('Bela Tarr','F','1953-01-29');
INSERT INTO director(name,gender,dob) VALUES ('Steven Spielberg','M','1975-10-13');
INSERT INTO director(name,gender,dob) VALUES ('Luca Guadagnino','F','1974-02-28');
INSERT INTO director(name,gender,dob) VALUES ('Bong Joon-ho','F','1955-04-26');
INSERT INTO director(name,gender,dob) VALUES ('Sam Mendes','M','1954-02-14');
INSERT INTO director(name,gender,dob) VALUES ('Fisher Stevens','F','1950-11-08');
INSERT INTO director(name,gender,dob) VALUES ('Christopher Nolan','M','1934-05-04');
INSERT INTO director(name,gender,dob) VALUES ('Jean-Luc Godard','M','1930-07-14');
INSERT INTO director(name,gender,dob) VALUES ('George Miller','M','1944-02-17');


INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Satantango',450,9.1,'Hungarian');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('A.I. Artificial Intelligence',146,8,'English');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('I am Love',120,7.6,'Italian');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Snowpiercer',126,8.9,'English');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Munich',164,8.1,'Hungarian');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Road to Perdition',117,8.2,'English');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Before The Flood',96,7.1,'French');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Skyfall',143,8.8,'English');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Inception',148,8.6,'English');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Goodbye to Language',70,7.9,'French');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('The Adventures of Tintin',97,7.2,'French');
INSERT INTO movie(title,running_time,critics_score,language) VALUES ('Mad Max: Fury Road',120,9.1,'English');


INSERT INTO starring(movie_title,actor_name) VALUES ('Satantango','Mihaly Vig');
INSERT INTO starring(movie_title,actor_name) VALUES ('Satantango','Putyi Horvath');
INSERT INTO starring(movie_title,actor_name) VALUES ('Satantango','Laszlo Lugossy');
INSERT INTO starring(movie_title,actor_name) VALUES ('A.I. Artificial Intelligence','Haley Joel Osment');
INSERT INTO starring(movie_title,actor_name) VALUES ('A.I. Artificial Intelligence','Jude Law');
INSERT INTO starring(movie_title,actor_name) VALUES ('A.I. Artificial Intelligence','Frances O’Connor');
INSERT INTO starring(movie_title,actor_name) VALUES ('I am Love','Tilda Swinton');
INSERT INTO starring(movie_title,actor_name) VALUES ('I am Love','Gabriele Ferzetti');
INSERT INTO starring(movie_title,actor_name) VALUES ('I am Love','Marisa Berenson');
INSERT INTO starring(movie_title,actor_name) VALUES ('Snowpiercer','Chris Evans');
INSERT INTO starring(movie_title,actor_name) VALUES ('Snowpiercer','Song Kang-ho');
INSERT INTO starring(movie_title,actor_name) VALUES ('Snowpiercer','Tilda Swinton');
INSERT INTO starring(movie_title,actor_name) VALUES ('Snowpiercer','Jamie Bell');
INSERT INTO starring(movie_title,actor_name) VALUES ('Munich','Eric Bana');
INSERT INTO starring(movie_title,actor_name) VALUES ('Munich','Daniel Craig');
INSERT INTO starring(movie_title,actor_name) VALUES ('Munich','Ciaran Hinds');
INSERT INTO starring(movie_title,actor_name) VALUES ('Road to Perdition','Tom Hanks');
INSERT INTO starring(movie_title,actor_name) VALUES ('Road to Perdition','Paul Newman');
INSERT INTO starring(movie_title,actor_name) VALUES ('Road to Perdition','Jude Law');
INSERT INTO starring(movie_title,actor_name) VALUES ('Road to Perdition','Daniel Craig');
INSERT INTO starring(movie_title,actor_name) VALUES ('Road to Perdition','Ciaran Hinds');
INSERT INTO starring(movie_title,actor_name) VALUES ('Before The Flood','Leonardo DiCaprio');
INSERT INTO starring(movie_title,actor_name) VALUES ('Skyfall','Daniel Craig');
INSERT INTO starring(movie_title,actor_name) VALUES ('Skyfall','Javier Bardem');
INSERT INTO starring(movie_title,actor_name) VALUES ('Skyfall','Judi Dench');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Leonardo DiCaprio');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Ken Watanabe');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Marion Cotillard');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Ellen Page');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Joseph Gordon-Levitt');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Tom Hardy');
INSERT INTO starring(movie_title,actor_name) VALUES ('Inception','Cillian Murphy');
INSERT INTO starring(movie_title,actor_name) VALUES ('Goodbye to Language','Heloise Godet');
INSERT INTO starring(movie_title,actor_name) VALUES ('Goodbye to Language','Kamel Abdeli');
INSERT INTO starring(movie_title,actor_name) VALUES ('Goodbye to Language','Richard Chevallier');
INSERT INTO starring(movie_title,actor_name) VALUES ('Goodbye to Language','Zoe Bruneau');
INSERT INTO starring(movie_title,actor_name) VALUES ('The Adventures of Tintin','Jamie Bell');
INSERT INTO starring(movie_title,actor_name) VALUES ('The Adventures of Tintin','Andy Serkis');
INSERT INTO starring(movie_title,actor_name) VALUES ('The Adventures of Tintin','Daniel Craig');
INSERT INTO starring(movie_title,actor_name) VALUES ('The Adventures of Tintin','Nick Frost');
INSERT INTO starring(movie_title,actor_name) VALUES ('The Adventures of Tintin','Simon Pegg');
INSERT INTO starring(movie_title,actor_name) VALUES ('Mad Max: Fury Road','Tom Hardy');
INSERT INTO starring(movie_title,actor_name) VALUES ('Mad Max: Fury Road','Charlize Theron');
INSERT INTO starring(movie_title,actor_name) VALUES ('Mad Max: Fury Road','Nicholas Hoult');


INSERT INTO directed_by(movie_title,director_name) VALUES ('Satantango','Bela Tarr');
INSERT INTO directed_by(movie_title,director_name) VALUES ('A.I. Artificial Intelligence','Steven Spielberg');
INSERT INTO directed_by(movie_title,director_name) VALUES ('I am Love','Luca Guadagnino');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Snowpiercer','Bong Joon-ho');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Munich','Steven Spielberg');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Road to Perdition','Sam Mendes');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Before The Flood','Fisher Stevens');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Skyfall','Sam Mendes');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Inception','Christopher Nolan');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Goodbye to Language','Jean-Luc Godard');
INSERT INTO directed_by(movie_title,director_name) VALUES ('The Adventures of Tintin','Steven Spielberg');
INSERT INTO directed_by(movie_title,director_name) VALUES ('Mad Max: Fury Road','George Miller');


INSERT INTO format(format_id,category) VALUES ('SE1','2D');
INSERT INTO format(format_id,category) VALUES ('SE2','3D');
INSERT INTO format(format_id,category) VALUES ('SE3','IMAX 2D');
INSERT INTO format(format_id,category) VALUES ('SE4','IMAX 3D');
INSERT INTO format(format_id,category) VALUES ('SE5','Gold Class');


INSERT INTO shown_in(movie_title,format_id) VALUES ('Satantango','SE5');
INSERT INTO shown_in(movie_title,format_id) VALUES ('A.I. Artificial Intelligence','SE1');
INSERT INTO shown_in(movie_title,format_id) VALUES ('I am Love','SE1');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Snowpiercer','SE1');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Munich','SE1');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Road to Perdition','SE1');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Before The Flood','SE5');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Skyfall','SE3');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Inception','SE3');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Goodbye to Language','SE2');
INSERT INTO shown_in(movie_title,format_id) VALUES ('The Adventures of Tintin','SE4');
INSERT INTO shown_in(movie_title,format_id) VALUES ('Mad Max: Fury Road','SE4');


INSERT INTO show(show_id,show_date,show_time) VALUES ('G_SAT1','2017/05/13','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_SAT2','2017/05/14','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_AIA1','2017/05/13','16:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_AIA2','2017/05/14','16:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_BEF1','2017/05/13','19:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_BEF2','2017/05/14','19:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_MAD1','2017/05/13','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_MAD2','2017/05/14','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_SKY1','2017/05/13','11:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_SKY2','2017/05/14','11:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_INC1','2017/05/13','13:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_INC2','2017/05/14','13:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_THE1','2017/05/13','16:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_THE2','2017/05/14','16:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_INC3','2017/05/13','18:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('I_INC4','2017/05/14','18:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO1','2017/05/13','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO2','2017/05/14','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_THE3','2017/05/13','10:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_THE4','2017/05/14','10:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO3','2017/05/13','12:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO4','2017/05/14','12:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_MAD3','2017/05/13','13:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_MAD4','2017/05/14','13:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_THE3','2017/05/13','15:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_THE4','2017/05/14','15:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO5','2017/05/13','17:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_GOO6','2017/05/14','17:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_MAD5','2017/05/13','18:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('D_THES','2017/05/14','18:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA1','2017/05/12','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA2','2017/05/15','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_AIA3','2017/05/12','11:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_AIA4','2017/05/15','11:10:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA3','2017/05/12','13:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA4','2017/05/15','13:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_SKY3','2017/05/12','16:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_INCS','2017/05/15','16:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA5','2017/05/12','18:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('2_ROA6','2017/05/15','18:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_MUN1','2017/05/12','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_MUN2','2017/05/15','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_SNO1','2017/05/12','12:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_SNO2','2017/05/15','12:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_IAM1','2017/05/12','14:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_IAM2','2017/05/15','14:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_SNO3','2017/05/12','16:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_SNO4','2017/05/15','16:30:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_IAM3','2017/05/12','18:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('1_IAM4','2017/05/15','18:50:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_SAT3','2017/05/12','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_SAT4','2017/05/15','09:00:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_AIA5','2017/05/12','16:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_AIA6','2017/05/15','16:40:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_BEF3','2017/05/12','19:20:00');
INSERT INTO show(show_id,show_date,show_time) VALUES ('G_BEF4','2017/05/15','19:20:00');


INSERT INTO screening(show_id,movie_title) VALUES ('G_SAT1','Satantango');
INSERT INTO screening(show_id,movie_title) VALUES ('G_SAT2','Satantango');
INSERT INTO screening(show_id,movie_title) VALUES ('G_AIA1','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('G_AIA2','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('G_BEF1','Before The Flood');
INSERT INTO screening(show_id,movie_title) VALUES ('G_BEF2','Before The Flood');
INSERT INTO screening(show_id,movie_title) VALUES ('I_MAD1','Mad Max: Fury Road');
INSERT INTO screening(show_id,movie_title) VALUES ('I_MAD2','Mad Max: Fury Road');
INSERT INTO screening(show_id,movie_title) VALUES ('I_SKY1','Skyfall');
INSERT INTO screening(show_id,movie_title) VALUES ('I_SKY2','Skyfall');
INSERT INTO screening(show_id,movie_title) VALUES ('I_INC1','Inception');
INSERT INTO screening(show_id,movie_title) VALUES ('I_INC2','Inception');
INSERT INTO screening(show_id,movie_title) VALUES ('I_THE1','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('I_THE2','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('I_INC3','Inception');
INSERT INTO screening(show_id,movie_title) VALUES ('I_INC4','Inception');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO1','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO2','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_THE3','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('D_THE4','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO3','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO4','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_MAD3','Mad Max: Fury Road');
INSERT INTO screening(show_id,movie_title) VALUES ('D_MAD4','Mad Max: Fury Road');
INSERT INTO screening(show_id,movie_title) VALUES ('D_THE3','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('D_THE4','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO5','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_GOO6','Goodbye to Language');
INSERT INTO screening(show_id,movie_title) VALUES ('D_MAD5','Mad Max: Fury Road');
INSERT INTO screening(show_id,movie_title) VALUES ('D_THES','The Adventures of Tintin');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA1','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA2','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('2_AIA3','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('2_AIA4','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA3','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA4','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('2_SKY3','Skyfall');
INSERT INTO screening(show_id,movie_title) VALUES ('2_INCS','Inception');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA5','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('2_ROA6','Road to Perdition');
INSERT INTO screening(show_id,movie_title) VALUES ('1_MUN1','Munich');
INSERT INTO screening(show_id,movie_title) VALUES ('1_MUN2','Munich');
INSERT INTO screening(show_id,movie_title) VALUES ('1_SNO1','Snowpiercer');
INSERT INTO screening(show_id,movie_title) VALUES ('1_SNO2','Snowpiercer');
INSERT INTO screening(show_id,movie_title) VALUES ('1_IAM1','I am Love');
INSERT INTO screening(show_id,movie_title) VALUES ('1_IAM2','I am Love');
INSERT INTO screening(show_id,movie_title) VALUES ('1_SNO3','Snowpiercer');
INSERT INTO screening(show_id,movie_title) VALUES ('1_SNO4','Snowpiercer');
INSERT INTO screening(show_id,movie_title) VALUES ('1_IAM3','I am Love');
INSERT INTO screening(show_id,movie_title) VALUES ('1_IAM4','I am Love');
INSERT INTO screening(show_id,movie_title) VALUES ('G_SAT3','Satantango');
INSERT INTO screening(show_id,movie_title) VALUES ('G_SAT4','Satantango');
INSERT INTO screening(show_id,movie_title) VALUES ('G_AIA5','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('G_AIA6','A.I. Artificial Intelligence');
INSERT INTO screening(show_id,movie_title) VALUES ('G_BEF3','Before The Flood');
INSERT INTO screening(show_id,movie_title) VALUES ('G_BEF4','Before The Flood');


INSERT INTO auditorium(number) VALUES (1);
INSERT INTO auditorium(number) VALUES (2);
INSERT INTO auditorium(number) VALUES (3);
INSERT INTO auditorium(number) VALUES (4);
INSERT INTO auditorium(number) VALUES (5);
INSERT INTO auditorium(number) VALUES (6);
INSERT INTO auditorium(number) VALUES (7);
INSERT INTO auditorium(number) VALUES (8);
INSERT INTO auditorium(number) VALUES (9);
INSERT INTO auditorium(number) VALUES (10);


INSERT INTO seat(row_num,col_num,price) VALUES ('A',1,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('A',2,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('A',3,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('B',1,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('B',2,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('B',3,200);
INSERT INTO seat(row_num,col_num,price) VALUES ('C',1,250);
INSERT INTO seat(row_num,col_num,price) VALUES ('C',2,250);
INSERT INTO seat(row_num,col_num,price) VALUES ('C',3,250);
INSERT INTO seat(row_num,col_num,price) VALUES ('D',1,300);
INSERT INTO seat(row_num,col_num,price) VALUES ('D',2,300);
INSERT INTO seat(row_num,col_num,price) VALUES ('D',3,300);


INSERT INTO customer(email,password,name,phone_number,balance) VALUES ('plague300@hackersrepublic.com','pineapple9','Plague',8671938004,30000);
INSERT INTO customer(email,password,name,phone_number,balance) VALUES ('trinity6@hackersrepublic.com','london94','Trinity',8278394466,15000);
INSERT INTO customer(email,password,name,phone_number,balance) VALUES ('wasp4@hackersrepulic.com','umikael','Wasp',8872941670,120000);
INSERT INTO customer(email,password,name,phone_number,balance) VALUES ('mikaelblom@millenium.com','hanserik','Mikael Blomkvist',8792241000,55000);
*/


