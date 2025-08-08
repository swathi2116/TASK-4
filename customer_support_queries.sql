-- 1. Basic SELECT + GROUP BY
SELECT category, COUNT(*) AS ticket_count
FROM customer_support_data
GROUP BY category
ORDER BY ticket_count DESC
LIMIT 5;

-- 2. Aggregate Functions
SELECT Agent_name, AVG(`CSAT Score`) AS avg_csat
FROM customer_support_data
GROUP BY Agent_name
ORDER BY avg_csat DESC;

-- 3. Subquery
SELECT Agent_name
FROM customer_support_data
GROUP BY Agent_name
HAVING AVG(`CSAT Score`) > (
    SELECT AVG(`CSAT Score`) FROM customer_support_data
);

-- 4. JOIN Example
CREATE TABLE agent_details (
    Agent_name VARCHAR(100),
    Location VARCHAR(50),
    Experience_Years INT
);

SELECT c.Agent_name, a.Location, AVG(c.`CSAT Score`) AS avg_csat
FROM customer_support_data c
INNER JOIN agent_details a 
    ON c.Agent_name = a.Agent_name
GROUP BY c.Agent_name, a.Location;

-- 5. Create a View
CREATE VIEW monthly_ticket_count AS
SELECT DATE_FORMAT(STR_TO_DATE(`Issue_reported at`, '%d/%m/%Y %H:%i'), '%Y-%m') AS month,
       COUNT(*) AS total_tickets
FROM customer_support_data
GROUP BY month;

-- 6. Index for Optimization
CREATE INDEX idx_agent_name ON customer_support_data (Agent_name);

-- 7. LEFT JOIN Example (Unanswered Tickets)
SELECT Unique_id, category, Order_id
FROM customer_support_data
WHERE Order_id IS NULL;
