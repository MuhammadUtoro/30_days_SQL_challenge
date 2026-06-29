-- Exercise for String and Numeric Functions
-- 1. Write a query to identify records where road_name or district have leading or trailing spaces. Compare LENGTH(road_name) against LENGTH(TRIM(road_name)) to surface any rows where extra whitespace is present.

-- 2. Write a query that returns a cleaned version of the data. Use TRIM to remove extra whitespace from road_name, district, and repair_type. Use INITCAP to standardise the casing on road_name and UPPER for district. Show the repair_ref alongside the cleaned columns.

-- 3. For each repair, calculate the cost variance between actual_cost and estimated_cost. Use ROUND to display the variance to 2 decimal places. Add a second column showing the variance as a percentage of estimated cost, also rounded to 2 decimal places. Show repair_ref, road_name (trimmed), and both variance columns.

-- 4. The repair_ref column contains structured codes in the format RD-XXX-Y-NNNN. Extract the city code (characters 4-6, e.g. LON, BRI, MAN, EDI) using SUBSTRING. Show repair_ref, the extracted city code as city_code, and the trimmed road_name.
