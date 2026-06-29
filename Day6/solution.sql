-- Used tables: vehicles, depots, shipments, drivers
-- 1. Query all four tables to understand what you are working with. How many depots are there? What vehicle types exist? How many shipments are in each status? Get a feel for the data before changing anything. 
SELECT * FROM depots; -- 6 depots
SELECT * FROM drivers; -- 12 drivers
SELECT * FROM vehicles; -- 3 types: lorry, truck and van
SELECT status, COUNT(*) FROM shipments GROUP BY status;

-- 2. Find all shipments where the status is 'delivered' but delivery_date is NULL. These have been mislabelled. There should be 4 of them (shipments 9, 33, 51, 73) - look for the notes that say "status needs review".
SELECT shipment_id, delivery_date, notes FROM shipments WHERE status = 'delivered';

-- 3. Update those 4 records: change their status from 'delivered' to 'pending' since we do not know when they were actually delivered. Always SELECT before UPDATE to preview what will change
UPDATE shipments SET status = 'pending'
WHERE status = 'delivered' AND delivery_date IS NULL;

-- 4. Find all shipments where the status is 'in_transit' but delivery_date IS NOT NULL. These have actually been delivered. There should be 3 of them (shipments 12, 37, 57) - look for the notes that say "actually delivered".
SELECT shipment_id, status, delivery_date, notes
FROM shipments
WHERE status = 'in_transit' AND delivery_date IS NOT NULL;

-- 5. Update those 3 records: change their status from 'in_transit' to 'delivered'. Again, SELECT first to preview.
UPDATE shipments
SET status = 'delivered'
WHERE status = 'in_transit' AND delivery_date IS NOT NULL;

-- 6. Use GROUP BY on tracking_code with HAVING COUNT(*) > 1 to find duplicate tracking codes. There should be 5 duplicated codes. Examine them to confirm they are genuine copies from the system migration
SELECT tracking_code, COUNT(*) AS tracking_code_count FROM shipments GROUP BY tracking_code HAVING COUNT(tracking_code) > 1;

-- 7. Delete the duplicate rows (the ones with the higher shipment_id - these are the migration copies, shipments 116-120). After deletion, the shipment count should drop from 120 to 11
SELECT shipment_id, tracking_code FROM shipments
WHERE tracking_code IN (
    SELECT tracking_code,
    COUNT(*) AS track_count
    FROM shipments
    GROUP BY tracking_code
    HAVING COUNT(*) > 1
)
ORDER BY shipment_id, tracking_code;

DELETE FROM shipments
WHERE shipment_id IN(
    SELECT MAX(shipment_id)
FROM shipments
GROUP BY tracking_code
HAVING COUNT(*) > 1
);

-- 8. Now that the data is clean, build the board report. Calculate total shipments by status, shipments per depot, total revenue by region, and the overall delivery rate. These are the numbers the operations director takes to the board.
-- Total shipments by status: 
SELECT status, COUNT(shipment_id) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY status_count DESC;
-- Total revenue by region 
SELECT region,
SUM(cost) AS total_revenue
FROM shipments
GROUP BY region
ORDER BY total_revenue DESC;
-- Total shipments per depot
SELECT d.depot_name,
COUNT(shipment_id)
FROM depots d
INNER JOIN shipments s
ON d.depot_name = s.depot_name
GROUP BY d.depot_name
ORDER BY count DESC;

-- KPI, total_revenue, total_shipments, revenue per shipment
SELECT
COUNT(shipment_id) AS total_shipment,
SUM(cost) AS total_revenue,
ROUND(AVG(cost),2) AS avg_revenue_per_shipment
FROM shipments;

