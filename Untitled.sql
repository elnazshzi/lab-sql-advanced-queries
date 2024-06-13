-- List each pair of actors that have worked together.

select * from sakila.film_actor;


use sakila;
SELECT 
    a1.actor_id AS actor1_id,
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.actor_id AS actor2_id,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name,
    title
FROM 
    film_actor fa1
JOIN 
    film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
JOIN 
    actor a1 ON fa1.actor_id = a1.actor_id
JOIN 
    actor a2 ON fa2.actor_id = a2.actor_id
    
JOIN film f ON fa1.film_id = f.film_id

ORDER BY 
    a1.actor_id, a2.actor_id;


-- 2. For each film, list actor that has acted in more films

-- For each film, list actor that has acted in more films.


with actor_filmcount as (
select actor_id, count(film_id) as num_films
from sakila.film_actor
group by actor_id
) 


select f.title, a.first_name, last_name, afc.num_films
from
      sakila.film f
join
     sakila.film_actor fa ON f.film_id = fa.film_id
join
      sakila.actor a ON fa.actor_id = a.actor_id
join
      actor_filmcount afc ON a.actor_id = afc.actor_id
where 
      afc.num_films = (
                   select MAX(afc.num_films)
                   from sakila.film_actor fa2
                   join actor_filmcount afc on fa2.actor_id = afc.actor_id
                   where fa2.film_id = f.film_id
                   )

order by f.title;




