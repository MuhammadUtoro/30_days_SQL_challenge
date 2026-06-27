-- Create a novapay_merchants table with: merchant_id as an auto-incrementing primary key, merchant_name (required, max 100 characters), contact_email (required and unique), category (must be one of 'retail', 'hospitality', 'saas', or 'marketplace'), monthly_volume_limit (must be greater than zero), onboarded_date (defaults to today), and is_active (defaults to TRUE)
CREATE TABLE novapay_merchants (
    merchant_id SERIAL PRIMARY KEY,
    merchant_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL
            CHECK (category IN('retail', 'hospitality', 'saas', 'marketplace')),
    monthly_volume_limit NUMERIC NOT NULL
            CONSTRAINT positive_number CHECK (monthly_volume_limit > 0),
    onboarded_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Insert two valid merchants into your novapay_merchants table - one with category 'retail' and one with category 'saas'. Then SELECT all rows to confirm they were inserted correctly.
INSERT INTO novapay_merchants (
merchant_name, contact_email, category, monthly_volume_limit)
VALUES('Slayer Merch', 'tomaraya@slayermerch.com', 'retail', 45000);
INSERT INTO novapay_merchants (
merchant_name, contact_email, category, monthly_volume_limit)
VALUES('Obscura Goods', 'obscuraa@band.com', 'saas', 49000);

-- Create a novapay_transactions table with a foreign key linking to merchants, a CHECK constraint ensuring the amount is greater than zero, currency restricted to 'GBP', 'EUR', or 'USD', status restricted to 'pending', 'completed', 'failed', or 'refunded', and ON DELETE CASCADE. 
CREATE TABLE novapay_transactions (
transaction_id SERIAL PRIMARY KEY,
merchant_id INTEGER NOT NULL
REFERENCES novapay_merchants(merchant_id) ON DELETE CASCADE,
amount NUMERIC NOT NULL
CONSTRAINT positive_number CHECK (amount > 0),
currency VARCHAR(10) NOT NULL
CHECK (currency IN('USD', 'EUR', 'GBP')),
status VARCHAR(20) NOT NULL
CHECK (status IN('pending', 'completed', 'failed', 'refunded')));

-- Create a novapay_employees table with CHECK constraints on department (must be 'engineering', 'operations', 'compliance', or 'sales'), role level (must be 'junior', 'mid', 'senior', 'lead', or 'head'), and salary (must be between 25,000 and 250,000). Include a required start_date with no default.
CREATE TABLE novapay_employees (
employee_id SERIAL PRIMARY KEY,
department VARCHAR(30) NOT NULL
CHECK (department IN('engineering', 'operations', 'compliance','sales')),
role_level VARCHAR(30) NOT NULL
CHECK (role_level IN('junior', 'mid', 'senior', 'lead', 'head')),
salary NUMERIC NOT NULL
CONSTRAINT between_these_values CHECK (salary BETWEEN 25000 AND 250000),
start_date DATE NOT NULL);

-- Test your constraints by attempting these inserts. Each one should fail - verify that the database rejects them and understand why:

    -- Insert a merchant with a duplicate email
    -- Insert a merchant with category 'crypto'
    -- Insert a transaction with a negative amount
    -- Insert a transaction referencing a non-existent merchant (merchant_id 999)

