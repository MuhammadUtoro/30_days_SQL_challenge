-- Day 4 of 30 of SQL Challenge
-- 1. Three new tickets came in over the weekend. Add them to the support_tickets table:
-- Suki Patel (suki@pateldesign.co.uk) - "Heatmap not tracking mobile clicks", High priority, Open, unassigned, created 2025-04-16, product: Heatmap Tracker
-- Jordan Marsh (jordan@marshconsulting.com) - "Need invoice for April", Low priority, Open, unassigned, created 2025-04-16, product: Enterprise Dashboard
-- Freya Mitchell (freya@mitchellhr.com) - "A/B test variant not loading", Medium priority, Open, unassigned, created 2025-04-16, product: A/B Test Runner
INSERT INTO support_tickets (customer_name, customer_email, subject, priority, status, assigned_to, created_date, product_name) VALUES
('Suki Patel', 'suki@pateldesign.co.uk', 'Heatmap not tracking mobile clicks', 'High', 'Open', 'Unassigned', '2025-04-16', 'Heatmap Tracker'),
('Jordan Marsh', 'jordan@marshconsulting.com', 'Need invoice for April', 'Low', 'Open', 'Unassigned', '2025-04-16', 'A/B Test Runner'),
('Freya Mitchell', 'freya@mitchellhr.com', 'A/B test variant not loading', 'Medium', 'Open', 'Unassigned', '2025-04-16', 'A/B Test Runner');

-- 2. Tobias wants all unassigned Open tickets assigned to a new agent called Suki Patel. Before running the UPDATE, write the SELECT query you would use to preview which tickets would be affected. Then apply the update. How many tickets does Suki get?
-- Test query
SELECT customer_name FROM support_tickets WHERE status='Open' AND assigned_to='Unassigned';
-- Update query
UPDATE support_tickets
SET assigned_to = 'Suki Patel'
WHERE status = 'Open'
    AND assigned_to = 'Unassigned';

-- 3. Tobias says all Heatmap Tracker tickets that are not already High priority should be escalated. Find any Heatmap Tracker tickets where priority is not High and update them. Before running the UPDATE, write the SELECT query to preview the affected rows.
-- Test query
SELECT ticket_id FROM support_tickets WHERE product_name = 'Heatmap Tracker' AND priority != 'High';
-- Update query
UPDATE support_tickets
SET priority = 'High'
WHERE product_name = 'Heatmap Tracker'
    AND priority != 'High';

-- 4. Tobias wants all Cancelled tickets removed from the live system. Write the DELETE query to remove them. Before running it, write the SELECT query to preview how many rows will be affected.
-- Test query
SELECT ticket_id FROM support_tickets WHERE status = 'Cancelled';
-- Delete query
DELETE FROM support_tickets
WHERE status = 'Cancelled';

-- 5. The data pipeline runs nightly. Before each load, the staging tables must be wiped so yesterday's data does not carry over. Write the TRUNCATE statement to clear the staging_daily_metrics table. Why is TRUNCATE faster than DELETE for this job?
TRUNCATE TABLE staging_daily_metrics;
-- DELETE use logic row-wise action
-- TRUNCATE does not scan row-wise

-- 6. The legacy tables are no longer needed - the product team has confirmed they can be removed entirely. Drop both legacy_ticket_categories and legacy_pricing_v1. What is the difference between DROP and TRUNCATE?
DROP TABLE legacy_ticket_categories, legacy_pricing_v1;
-- DROP: delete the table entirely from the schema and completely from DB
-- TRUNCATE: only delete the rows but structure, columns and constraints stay
