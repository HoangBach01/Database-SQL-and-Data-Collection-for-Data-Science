-- 2a
SELECT customer_id, first_name, last_name, email, active,
	CASE WHEN active=1 THEN 'Đang hoạt động' ELSE 'Ngưng hoạt động' END AS tinh_trang
	FROM public.customer
	ORDER BY first_name, last_name;
-- 2b
SELECT film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, 
	rating, last_update, special_features, fulltext
	FROM public.film
	WHERE rental_rate>4;
-- 2c
SELECT *
	FROM public.film
	WHERE length BETWEEN 100 AND 120;
-- 2d
SELECT actor_id, first_name, last_name, last_update
	FROM public.actor
	WHERE first_name LIKE '%r_';
-- 2e
SELECT actor_id, first_name, last_name, last_update
	FROM public.actor
	WHERE first_name LIKE '_r%r_';

-- 3a
SELECT c.name AS ten_the_loai, COUNT(*) AS so_phim
	FROM public.film_category f JOIN public.category c ON f.category_id=c.category_id
	GROUP BY c.name;
-- 3b
SELECT language_id, name
	FROM public.language
	WHERE language_id NOT IN (SELECT language_id FROM public.film);
-- 3c
SELECT DISTINCT c.category_id, c.name
	FROM public.film_category f JOIN public.category c ON f.category_id=c.category_id
	JOIN public.film i ON f.film_id=i.film_id
	JOIN public.language l ON l.language_id=i.language_id
	WHERE l.name='English'
	ORDER BY c.category_id;
-- 3d
SELECT *
FROM public.film f JOIN public.film_actor fa ON f.film_id=fa.film_id
JOIN public.actor a ON a.actor_id=fa.actor_id
WHERE a.first_name='Jennifer' AND a.last_name='Davis'
ORDER BY f.film_id;
-- 3e
SELECT category_id, name
FROM public.category
WHERE category_id IN
(
SELECT category_id
FROM public.film_category
GROUP BY category_id
ORDER BY COUNT(*) DESC
LIMIT 10
);
-- 3f
SELECT f.*
FROM public.rental r JOIN public.customer c ON r.customer_id=c.customer_id
JOIN public.inventory i ON i.inventory_id=r.inventory_id
JOIN public.film f ON f.film_id=i.film_id
WHERE c.first_name='Mary' AND c.last_name='Smith';
-- 3g
SELECT *
FROM public.film
WHERE film_id IN
(
SELECT i.film_id
FROM public.rental r JOIN public.inventory i ON i.inventory_id=r.inventory_id
GROUP BY i.film_id
ORDER BY COUNT(*) DESC
LIMIT 1
);
-- 3h
SELECT *
FROM public.film
WHERE film_id IN
(
SELECT i.film_id
FROM public.rental r JOIN public.inventory i ON i.inventory_id=r.inventory_id
GROUP BY i.film_id
ORDER BY COUNT(*) DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY	
);


		