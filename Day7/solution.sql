-- 1. Write a single query that counts the number of NULLs in cost_price, supplier_name, and category. Use the COUNT(*) - COUNT(column) pattern to produce a summary row showing how many gaps exist in each column.
SELECT
    COUNT(cost_price) AS cost_null_count,
    COUNT(supplier_name) AS supp_null_count,
    COUNT(category) AS cat_null_count
    FROM menu_items
WHERE cost_price IS NULL OR supplier_name IS NULL OR category IS NULL;

-- 2. For every menu item, show the item name, sell price, cost price, and a display_cost column that shows the cost price if known, or the text 'Cost not recorded' if it is NULL. Use COALESCE.
SELECT
    item_name,
    sell_price,
    COALESCE(cost_price::text, 'Cost not recorded') AS display_cost
    FROM menu_items;

-- 3. Find all menu items that have no category assigned. Show the item name, sell price, and stock quantity. How many items are uncategorised?
SELECT
    item_name,
    sell_price,
    stock_quantity
    FROM menu_items
WHERE category IS NULL;

-- 4. Find all items with fewer than 20 units in stock where the supplier name is also NULL. These are the urgent procurement blind spots. Show the item name, stock quantity, and sell price.
SELECT
    item_name,
    stock_quantity,
    sell_price
FROM menu_items
WHERE stock_quantity < 20 AND supplier_name IS NULL;

