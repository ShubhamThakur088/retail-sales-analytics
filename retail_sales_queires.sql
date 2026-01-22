SELECT * FROM retail_sales;

SELECT * FROM (
	SELECT  EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date), ROUND(AVG(total_sale),2) AS average_sales_monthly,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
	FROM retail_sales
	GROUP BY EXTRACT(MONTH FROM sale_date), EXTRACT(YEAR FROM sale_date) 
	ORDER BY EXTRACT(MONTH FROM sale_date), EXTRACT(YEAR FROM sale_date)
) AS t1 WHERE rank = 1;

SELECT customer_id, SUM(total_sale) AS sales FROM retail_sales GROUP BY customer_id ORDER BY sales DESC LIMIT 5;

SELECT COUNT(DISTINCT (customer_id)) AS unique_customers, category FROM retail_sales GROUP BY category; --category FROM retail_sales GROUP BY customer_id, category;

--OR sale_time > '17:00:00'

SELECT COUNT(transactions_id) AS num_of_transactions, sale_time, 'morning' AS sale_period FROM retail_sales 
GROUP BY sale_time HAVING sale_time <= '12:00:00'  
UNION
SELECT COUNT(transactions_id) AS num_of_transactions, sale_time, 'evening' AS sale_period FROM retail_sales
GROUP BY sale_time HAVING sale_time > '17:00:00'
UNION
SELECT COUNT(transactions_id) AS num_of_transations, sale_time, 'afternoon' AS sale_period FROM retail_sales
GROUP BY sale_time HAVING sale_time BETWEEN '12:00:00' AND '17:00:00'
ORDER BY sale_time ASC;