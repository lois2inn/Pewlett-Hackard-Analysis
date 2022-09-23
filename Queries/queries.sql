
-- Check data after csv imports
SELECT * FROM departments

SELECT * FROM employees where birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM dept_manager

SELECT * FROM dept_employee where emp_no = 10004

SELECT * FROM salaries

SELECT * FROM titles

-- employee data with birth_date in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- employee data with birth_date in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Retirement eligibility: 
-- birth date between 1952 and 1955
-- hire_date between 1985 and 1988
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Import the select results into another table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check if data is imported
select * from retirement_info

-- Drop retirement_info if exists
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_employee AS dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Using aliases get current list of employees retiring and import into a table
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employee as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Check for imported data
SELECT * FROM current_emp;

-- count of employees for each department.
SELECT COUNT(emp_no), dept_no 
FROM dept_employee
GROUP BY dept_no;

-- count of employees for each department in current retirement group order by dept.
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- count of employees for each department in current retirement group order by dept.
-- import data into a table
SELECT COUNT(ce.emp_no), de.dept_no
INTO current_emp_dept
FROM current_emp as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Get employee details and salary
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees as e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no

-- data from salaries table
SELECT * FROM salaries
ORDER BY to_date DESC;

-- all retiring employees with salaries
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
-- INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employee as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- retiring employees with department
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employee AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- retiring employees in Sales
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
FROM current_emp as ce
INNER JOIN dept_employee AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- retiring employees in Sales and Development
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
FROM current_emp as ce
INNER JOIN dept_employee AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development');