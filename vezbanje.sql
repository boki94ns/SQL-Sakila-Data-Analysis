USE sakila4_182;

SELECT SUM(p.amount) ukupna_zarada_videoklub
FROM payment p;

SELECT customer_id, SUM(p.amount) ukupna_zarada_videoklub
FROM payment p
GROUP BY customer_id;

SELECT p.staff_id, SUM(p.amount) ukupna_zarada_videoklub
FROM payment p
GROUP BY staff_id;

SELECT p.customer_id,
       DATE_FORMAT(p.payment_date, '%Y-%m') mesec,
       SUM(p.amount) AS ukupna_zarada
FROM payment p
GROUP BY p.customer_id, DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY p.customer_id ASC, ukupna_zarada DESC;

SELECT c.first_name, c.last_name, c.email,
       SUM(p.amount) AS ukupan_iznos,
       COUNT(p.payment_id) AS broj_uplata,
       AVG(p.amount),
       MAX(p.payment_date) AS poslednja_uplata
FROM customer c
INNER JOIN payment p USING (customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_film_actors AS
    SELECT f.film_id, f.title, COUNT(fa.actor_id) broj_glumaca
FROM film f
INNER JOIN film_actor fa USING (film_id)
GROUP BY f.film_id, f.title;
SELECT *
FROM tmp_film_actors;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_film_rentals AS
    SELECT f.film_id, f.title,
           COUNT(r.rental_id) AS broj_izdavanja
    FROM film f
    INNER JOIN inventory i USING (film_id)
    INNER JOIN rental r USING (inventory_id)
GROUP BY f.film_id, f.title
ORDER BY broj_izdavanja DESC;
SELECT *
FROM tmp_film_rentals;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_film_income AS
SELECT f.film_id, f.title,
       SUM(p.amount) ukupan_iznos
FROM film f
INNER JOIN inventory i USING (film_id)
INNER JOIN rental r USING (inventory_id)
INNER JOIN payment p USING (rental_id)
GROUP BY f.film_id, f.title
ORDER BY ukupan_iznos DESC ;
SELECT *
FROM tmp_film_income;


SELECT s.store_id id_prodavnice, st.staff_id zaposleni, SUM(p.amount) ukupan_iznos
FROM store s
INNER JOIN staff st USING (store_id)
INNER JOIN payment p USING (staff_id)
GROUP BY s.store_id, st.staff_id WITH ROLLUP
ORDER BY SUM(p.amount) DESC;

SELECT p.customer_id musterija, p.staff_id broj_zaposlenog, SUM(p.amount) ukupan_iznos
FROM payment p
WHERE p.customer_id < 4
GROUP BY p.customer_id, p.staff_id
WITH ROLLUP ;

SELECT p.customer_id musterija, p.staff_id broj_zaposlenog, SUM(p.amount) ukupan_iznos
FROM payment p
WHERE p.customer_id < 4
GROUP BY p.customer_id, p.staff_id
WITH ROLLUP
HAVING ukupan_iznos > 70;

SELECT p.customer_id klijent, SUM(p.amount) ukupan_iznos
FROM payment p
WHERE p.customer_id < 4
GROUP BY p.customer_id
WITH ROLLUP;

SELECT p.customer_id klijent, SUM(p.amount) ukupan_iznos
FROM payment p
WHERE p.customer_id < 4
GROUP BY p.customer_id
WITH ROLLUP
HAVING ukupan_iznos > 70;

SELECT a.actor_id, a.first_name, a.last_name, a.avg_film_rate,
       ROW_NUMBER() over (ORDER BY a.avg_film_rate DESC) rang
FROM actor_analytics a
ORDER BY rang;

SELECT a.actor_id, a.first_name, a.last_name,
       a.avg_film_rate, a.actor_payload, a.longest_movie_duration,
       MIN(a.avg_film_rate) OVER (ORDER BY a.actor_id ASC) najnize_ocenjeni_film,
       SUM(a.actor_payload) OVER (ORDER BY a.actor_id ASC) zarada_glumca,
       MAX(a.longest_movie_duration) OVER (ORDER BY a.actor_id ASC) najduzi_film
FROM actor_analytics a
ORDER BY a.actor_id ASC;

SELECT f.film_id,f.title,f.rentals,
       RANK() over (ORDER BY f.rentals DESC ) ranking,
       DENSE_RANK() over (ORDER BY f.rentals DESC ) dense,
       ROW_NUMBER() over (ORDER BY f.rentals DESC ) rownum
FROM film_analytics f
ORDER BY ranking;

SELECT DATEDIFF('2030-12-31','2000-01-01') +1 AS broj_dana;
SELECT
    ROW_NUMBER() over (ORDER BY payment.payment_id) rn
FROM payment
LIMIT 11323;
SELECT DATE_ADD('2000-01-01' INTERVAL 1 DAY );
SELECT DATE_ADD('2000-01-01', INTERVAL ROW_NUMBER()
    over (ORDER BY payment.payment_id)-1 DAY ) AS date
FROM payment
LIMIT 11323;


CREATE VIEW payments_summary AS

SELECT
    YEAR(p.payment_date) AS payment_year,
    MONTH(p.payment_date) AS payment_month,
    SUM(p.amount) AS total_amount
FROM payment p

GROUP BY
    payment_year, payment_month
WITH ROLLUP

ORDER BY
    payment_year DESC ,
    payment_month DESC ;


CREATE VIEW vezba AS
    SELECT
        EXTRACT(YEAR FROM p.payment_date) AS godina,
        EXTRACT(MONTH FROM p.payment_date) AS mesec,
        SUM(p.amount) AS total_amount
FROM payment p
    GROUP BY godina, mesec
    WITH ROLLUP
    ORDER BY godina DESC,
             mesec DESC;
SELECT *
FROM vezba;

