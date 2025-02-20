SELECT * FROM public.laptop_data;

--Check Total Number of Laptops
select count (*)as total_laptops From laptop_data;

-- Find the Average Price of Laptops
SELECT AVG(price) AS avg_price FROM laptop_data;

--Find the Most Expensive and Cheapest Laptops
SELECT * FROM laptop_data ORDER BY price DESC LIMIT 5;  -- Top 5 most expensive
SELECT * FROM laptop_data ORDER BY price ASC LIMIT 5;   -- Top 5 cheapest

-- Find Price Distribution by Brand
SELECT company, 
       COUNT(*) AS total_laptops, 
       AVG(price) AS avg_price, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price
FROM laptop_data
GROUP BY company
ORDER BY avg_price DESC;

-- Find the Most Common RAM Size
SELECT ram, COUNT(*) AS count_laptops
FROM laptop_data
GROUP BY ram
ORDER BY count_laptops DESC;

-- Find Average Price for Each RAM Size

SELECT ram, AVG(price) AS avg_price
FROM laptop_data
GROUP BY ram
ORDER BY avg_price DESC;

-- Check Performance Based on CPU
SELECT cpu, 
       COUNT(*) AS total_laptops, 
       AVG(price) AS avg_price
FROM laptop_data
GROUP BY cpu
ORDER BY avg_price DESC;

-- Find the Most Common Storage Type
SELECT memory, COUNT(*) AS count_laptops
FROM laptop_data
GROUP BY memory
ORDER BY count_laptops DESC;

-- Check Weight Distribution
SELECT 
    CASE 
        WHEN weight < 1.5 THEN 'Light (<1.5kg)'
        WHEN weight BETWEEN 1.5 AND 2.5 THEN 'Medium (1.5-2.5kg)'
        ELSE 'Heavy (>2.5kg)'
    END AS weight_category,
    COUNT(*) AS total_laptops
FROM laptop_data
GROUP BY weight_category
ORDER BY total_laptops DESC;

-- Find the Most Common Screen Size
SELECT inches, COUNT(*) AS count_laptops
FROM laptop_data
GROUP BY inches
ORDER BY count_laptops DESC;

-- Check the Impact of Screen Size on Price
SELECT inches, AVG(price) AS avg_price
FROM laptop_data
GROUP BY inches
ORDER BY avg_price DESC;

-- Find High-End Laptops (Expensive, Powerfu)
SELECT * 
FROM laptop_data 
WHERE ram >= 32 AND price > 1500 
ORDER BY price DESC;

-- Rank to each Laptop based on Price
SELECT price,
		company,
		ram,
		memory,
		RANK() OVER (ORDER BY Price DESC) As Price_rank
From laptop_data;

-- Rank Laptops Based on Multiple Criteria (Price + RAM)
SELECT 
    company, typename, ram, price,
    RANK() OVER (ORDER BY ram DESC, price DESC) AS performance_rank
FROM laptop_data;

-- Find the Cheapest Laptop Per Brand
SELECT * FROM (
    SELECT 
        company, typename, price,
        RANK() OVER (PARTITION BY company ORDER BY price ASC) AS cheapest_rank
    FROM laptop_data
) ranked
WHERE cheapest_rank = 1;

--  Rank Laptops Within Each Brand
SELECT 
    company, typename, price,
    RANK() OVER (PARTITION BY company ORDER BY price DESC) AS brand_rank
FROM laptop_data;

-- Most expensive laptop
SELECT 
    price,
    company,
    ram,
    memory,
    FIRST_VALUE(company) OVER (ORDER BY price DESC) AS most_expensive_company
FROM laptop_data;

-- Insights into price distribution.
SELECT 
    price,
    company,
    ram,
    memory,
    NTILE(4) OVER (ORDER BY price DESC) AS price_quartile
FROM laptop_data;

--






--






