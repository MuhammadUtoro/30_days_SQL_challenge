# 30 Days SQL Challenge

This repository contains my solutions for the 30 Days SQL challenge the SQL challenge based on the 30-Day SQL Challenge by SDW Online.

## Source

Challenge: 30-Day SQL Challenge - Day 02
https://github.com/sdw-online/30-Day-SQL-Challenge/blob/main/day-02/README.md

## Dataset

The exercises use a loan application dataset containing information such as:

* Applicant name
* Credit score
* Requested loan amount
* Annual income
* Employment status
* Loan purpose
* Approval status
* Region

## Tasks

### Q1

Select only the following columns for all applications:

* applicant_name
* credit_score
* requested_amount

---

### Q2

Find all applications from London.

**Goal:** Determine how many applications originated from London.

---

### Q3

Identify high-risk applications where:

* credit score is below 650
* requested amount is greater than $50,000

---

### Q4

Find approved Home Improvement applications from:

* London
* Edinburgh

This information helps evaluate expansion opportunities in those regions.

---

### Q5

Count self-employed applicants whose applications are still pending review.

**Condition:** No decision has been made yet.

---

### Q6

Find applications where the requested amount exceeds twice the applicant's annual income.

These applications may indicate elevated lending risk.

---

### Q7

Identify all pending applications where:

* credit score is below 600

**OR**

* requested amount exceeds annual income

These cases require urgent review before the board meeting.

## Topics Practiced

* SELECT
* WHERE
* Comparison operators
* Logical operators (AND, OR)
* IN
* NULL handling
* Aggregate functions (COUNT)
* Arithmetic expressions in SQL

## Database

* PostgreSQL

## Notes

This challenge focuses on filtering data using SQL conditions and combining multiple criteria to answer business-oriented questions.

