Simple Queries


#1 - Display films directed by Steven Spielberg

select movie_title 
from directed_by 
where director_name='Steven Spielberg';


#2 - Display films and language with critics score 9+

select title, language
from movie 
where critics_score>9;


#3 - Display cast of Inception in alphabetical order

select actor_name
from starring
where movie_title='Inception'
order by actor_name;


#4 - Display actresses and their date of births

select name, dob 
from actor 
where gender='F';


#5 - Display films starring Leonardo DiCaprio in reverse alphabetical order

select movie_title 
from starring 
where actor_name='Leonardo DiCaprio' 
order by movie_title desc;


#6 - Display auditoriums screening A.I. Artificial Intelligence

select h.audi_number 
from show_details h, screening s 
where h.show_id=s.show_id 
and s.movie_title='A.I. Artificial Intelligence'
group by h.audi_number;


#7 - Display format that Satantango is being screened in

select f.category 
from format f, shown_in s 
where s.movie_title='Satantango' 
and s.format_id=f.format_id;


#8 - Display director who directed films with runtime higher than 150 min

select d.director_name 
from directed_by d, movie m 
where m.running_time>150 
and m.title=d.movie_title;


#9 - Display films and show dates that are screened after 6:45 p.m.

select c.movie_title, h.show_date 
from screening c, show h 
where h.show_time>'18:45:00' 
and h.show_id=c.show_id;


#10 - Display films shown in IMAX 2D format

select movie_title 
from shown_in 
where format_id like '%3';


#11 - Rename column running_time to runtime

alter table movie 
rename running_time to runtime;


#12 - Doubles prices of all seats except Row A

update seat 
set price = price*2 
where row_num!='A';


---------------------------------------------------------------------------------------------------------------------------------------


Hard Queries


#1 - Display director of the film with the maximum runtime

select director_name 
from directed_by 
where movie_title in (
	select title 
	from movie 
	where runtime = (
		select max(runtime) 
		from movie));


#2 - Display actresses starring in non-English films

select name 
from actor 
where gender='F'
and name in (
	select actor_name 
	from starring 
	where movie_title in (
		select title 
		from movie 
		where language!='English'));


#3 - Display show date and time of Goodbye to Language of shows that are screened after 12:00

select show_date, show_time 
from show 
where show_time>'12:00:00'
and show_id in (
	select show_id 
	from screening 
	where movie_title='Goodbye to Language');


#4 - Display name and phone no of customer who booked for I am Love

select name, phone_number 
from customer 
where email in (
	select distinct cust_email 
	from booking 
	where show_id in (
		select show_id 
		from screening 
		where movie_title='I am Love'));


#5 - Display number of shows for The Adventures of Tintin on 2017/05/14

select count(*) 
from show 
where show_date='2017/05/14' 
and show_id in (
	select show_id 
	from screening 
	where movie_title='The Adventures of Tintin');


#6 - Display number of films shown in 2D

select count(*) 
from shown_in 
where format_id in (
	select format_id 
	from format 
	where category='2D');


#7 - Display director of the non-English films starring Daniel Craig

select director_name 
from directed_by 
where movie_title in (
	select movie_title 
	from starring 
	where actor_name='Daniel Craig'
	and movie_title in (
		select title 
		from movie 
		where language!='English'))
group by director_name;


#8 - Display average critics score of films starring Jamie Bell

select avg(critics_score) 
from movie 
where title in (
	select movie_title 
	from starring 
	where actor_name='Jamie Bell');


#9 - Display actors starring in films directed by Sam Mendes

select name 
from actor 
where name in (
	select actor_name 
	from starring 
	where movie_title in (
		select movie_title 
		from directed_by 
		where director_name='Sam Mendes')) 
group by name 
having gender='M';


#10 - Display films shown on all the days

select movie_title 
from screening 
where show_id in (
	select show_id 
	from show 
	where show_date='2017/05/12')
intersect 
select movie_title 
from screening 
where show_id in (
	select show_id 
	from show 
	where show_date='2017/05/13') 
intersect 
select movie_title 
from screening 
where show_id in (
	select show_id 
	from show 
	where show_date='2017/05/14') 
intersect 
select movie_title 
from screening 
where show_id in (
	select show_id 
	from show 
	where show_date='2017/05/15');


----------------------------------------------------------------------------------------------------------------------------------------


Complex Queries


#1 - Display films directed by female directors and various formats in which its shown

select m.title, f.category 
from movie m, format f 
where f.format_id in (
	select format_id 
	from shown_in 
	where movie_title in (
		select movie_title 
		from directed_by 
		where director_name in (
			select director 
			from director 
			where gender='F')));


#2 - Display Daniel Craig film in show after 18:00 on weekend less than 120 min runtime

select m.title, s.show_date, s.show_time 
from movie m, show s 
where m.runtime<120 
and title in (
	select movie_title 
	from starring 
	where actor_name='Daniel Craig')
and title in (
	select movie_title 
	from screening 
	where show_id=s.show_id)
and s.show_time>'18:00:00'
and (s.show_date='2017/05/13'
	 or s.show_date='2017/05/14');


#3 - Display film with an all male cast and its director

select movie_title, director_name 
from directed_by 
difference
select movie_title, director_name 
from directed_by 
where movie_title in (
	select movie_title 
	from starring 
	join actor on (
		gender='F' 
		and actor_name=name));


#4 - Display auditorium with highest number of seats booked?

select number 
from auditorium a 
where max(
	select count(s_row_num,s_col_num) 
	from show_details 
	where a.number=audi_number 
	and seat_status='B');


#5 - Display customers who spent more than 500 on booking tickets



#6 - Update show details seat status to booked when seat is booked i.e. when data is entered into booking



#7 - Display film title, director, runtime, language, format in a view

create view film_info as
    select m.title, d.director_name, m.runtime, m.language, f.category 
    from movie m, directed_by d, shown_in s, format f 
    where m.title=d.movie_title 
    and m.title=s.movie_title 
    and s.format_id=f.format_id;


#8 - Display directors who directed only English films with runtime less than 120 min

(select director_name 
 from directed_by 
 where movie_title in (
 	select title 
 	from movie 
 	where runtime<120)
 difference 
 (select director_name 
  from directed_by 
  join movie on (
  	language!='English' 
  	and title=movie_title)))
union
(select director_name 
 from directed_by 
 where movie_title in (
 	select title 
 	from movie 
 	where runtime<120) 
 difference 
 (select director_name 
  from directed_by 
  join movie on (
  	language='English' 
  	and title=movie_title)));


#9 - Display shows of an English language film on Monday before noon

select m.title, h.show_time 
from movie m, show h 
where m.title in (
	select movie_title 
	from screening 
	where show_id in (
		select show_id 
		from show 
		where show_id=h.show_id 
		and show_date='2017/05/15' 
		and show_time<='12:00:00'))
and m.language='English';


#10 - Display film title, director, critics score of films screened in at 09:00

create view film_review as
	select m.title, d.director_name, m.critics_score 
	from movie m, directed_by d, screening c, show h 
	where m.title=d.movie_title 
	and m.title=c.movie_title 
	and c.show_id=h.show_id 
	and h.show_time='09:00:00' 
	group by m.title, d.director_name;


