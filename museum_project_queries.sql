--Q1. Identify all the museums that remain open on sundays.

SELECT m.name AS museum_name,m.city,m.country,mh.day
FROM museum m
JOIN museum_hours mh ON m.museum_id= mh.museum_id
WHERE mh.day='Sunday';


--Q2. Find the top 5 artists who have created the highest numbers of paintings.

SELECT a.full_name AS artist_name,COUNT(w.work_id)AS total_paintings
FROM artist a 
JOIN work w ON a.artist_id=w.artist_id
GROUP BY a.full_name
ORDER BY total_paintings DESC
LIMIT 5;

--Q3. Identify the most expensive painting, its sale price, and the name of type museum where it is located.

SELECT W.name AS painting_name, m.name AS museum_name, ps.sale_price
FROM work w
JOIN museum m ON w.museum_id=m.museum_id
JOIN product_size ps ON w.work_id=ps.work_id
ORDER BY ps.sale_price DESC
LIMIT 1;

--Q4. Find the total number of museums located in each country and display them in descending order.

SELECT country , COUNT(museum_id) AS total_museums
FROM museum 
GROUP BY country 
ORDER BY total_museums DESC;

--Q5. Diplay the top 3 most expensive paintings for each artistic style using a window function.

SELECT style,painting_name, sale_price, painting_rank
FROM(SELECT w.style, w.name AS painting_name, ps.sale_price,
			ROW_NUMBER() OVER(PARTITION BY w.style ORDER BY ps.sale_price DESC)AS painting_rank
			FROM work w
			JOIN product_size ps ON w.work_id=ps.work_id
	)
	AS ranked_table
WHERE painting_rank <=3;








