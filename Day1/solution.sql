-- This is the solution for my Practice
-- 1. Select just the applicant_name, credit_score, and requested_amount
-- columns for all applications. Don't use SELECT * - pick only the three
-- columns Nia needs
SELECT application_id, region FROM loan_applications;

-- 2. Find all applications from London. How many are there? (7 applicants are
    -- from London)
SELECT COUNT(application_id) FROM loan_applications WHERE region='London';

-- 3. Which applications have a credit score below 650 AND are requesting more
-- than $50,000? These are the highest-risk candidates/ (11 applicants)
SELECT COUNT(application_id) FROM loan_applications WHERE credit_score<650 AND requested_amount>50000;

-- 4. Which applications from London or Edinburgh were for Home Improvement and
-- got approved? The board wants data to support expanding in those cities. (5
    -- Applicants)
SELECT COUNT(application_id) FROM loan_applications WHERE region IN ('London', 'Edinburgh') AND loan_purpose='Home Improvement' AND is_approved=true;

-- 5. How many self-employed applicants are still pending review (i.e. have no
    -- decision yet)? Applications sitting without a decision is a compliance
-- risk. (4 Applicants)
SELECT COUNT(application_id) FROM loan_applications WHERE employment_status = 'Self-employed' AND is_approved IS NULL;

-- 6. Find all applications where the requested amount is more than double the
-- applicant's annual income. These represent cases where the borrower is
-- asking for significantly more than they earn in a year - a key risk
-- indicator that Nia would want flagged separately (There are 5 applicants)
SELECT application_id, applicant_name FROM loan_applications WHERE requested_amount > 2*annual_income;

-- 7.Nia wants a single query that flags every pending application (no decision yet) where the credit score is below 600 OR the requested amount exceeds the applicant's annual income. These are the cases that need urgent review before the board meeting. How many are there? 
-- If we want only the number
WITH pending AS(
SELECT application_id, applicant_name, credit_score, annual_income, requested_amount, is_approved FROM loan_applications WHERE is_approved IS NULL)
SELECT COUNT(*) FROM pending WHERE credit_score < 600 OR requested_amount > annual_income;

-- If we want the details as well
WITH pending AS(
SELECT application_id, applicant_name, credit_score, annual_income, requested_amount, is_approved FROM loan_applications WHERE is_approved IS NULL)
SELECT * FROM pending WHERE credit_score < 600 OR requested_amount > annual_income;
