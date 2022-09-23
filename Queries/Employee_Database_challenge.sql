-- DELIVERABLE 1: Create a Retirement Titles table that holds all the titles of employees 
-- who were born between January 1, 1952 and December 31, 1955.

-- Step1: Retrieve emp_no, first_name, and last_name columns from the Employees table.
-- Step 2: Retrieve title, from_date, and to_date columns from the Titles table.
-- Step 3: Create a new table using the INTO clause.
-- Step 4: Join both tables on the primary key.
-- Step 5: Filter the data on the birth_date column to retrieve the employees who were born 
-- between 1952 and 1955. Then, order by the employee number.

SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	tt.title,
	tt.from_date,
	tt.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS tt
ON e.emp_no = tt.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no; 

-- TESTING: Check if retirement_titles table has records
-- SELECT * FROM retirement_titles;
-- Step 6: Exported above table as retirement_titles.csv
-- Step 7: Result Set as per image given on Canvas
-- Step 8: Copied code from starter.sql
-- Step 9: Retrieve employee number, first and last name, and title columns from the Retirement Titles table.
-- Step 10: Use Distinct with Orderby to remove duplicate rows
-- Step 11: Exclude those employees that have already left the company
-- Step 12: Create a Unique Titles table 
-- Step 13: Sort the Unique Titles table in ascending order by the employee number 
-- and descending order by the last date

SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- TESTING: Select results from unique_titles
-- SELECT * FROM unique_titles;

-- Step 14: Export the table as unique_titles.csv
-- Step 15: The data looks like image in Canvas
-- Step 16: Create a Retiring Titles table to hold the required information.
-- Step 17: Retrieve the number of titles from the Unique Titles table.
-- Step 18: Create a Retiring Titles table to hold the required information.
-- Step 19: Group the table by title, then sort the count column in descending order.

SELECT COUNT(emp_no), 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- TESTING: select rows from retiring_titles
-- SELECT * FROM retiring_titles;
-- Step 20: Export the Retiring Titles table as retiring_titles.csv 
-- Step 21: The results look like image in Canvas.


-- Deliverable 2: Create a mentorship-eligibility table that holds the 
-- current employees who were born between January 1, 1965 and December 31, 1965.

-- Step 1: Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Step 2: Retrieve the from_date and to_date columns from the Department Employee table.
-- Step 3: Retrieve the title column from the Titles table.
-- Step 4: Retrieve the first occurrence of the employee number for each set of rows 
-- defined by the ON () clause.
-- Step5: Create table with into clause
-- Step 6: Join the Employees and the Department Employee tables on the primary key.
-- Step 7: Join the Employees and the Titles tables on the primary key.
-- Step 8: Filter the data on the to_date column to all the current employees, 
-- then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
-- Step 9: Order the table by the employee number.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tt.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS tt
ON e.emp_no = tt.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;

-- Step 10: Exported mentorship_eligibility table as mentorship_eligibilty.csv into Pewlett-Hackard-Analysis folder.
