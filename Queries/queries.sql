-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-----------------------------------------------------------------------------

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-----------------------------------------------------------------------------

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-----------------------------------------------------------------------------

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
       retirement_info.first_name,
       retirement_info.last_name,
       dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;

-----------------------------------------------------------------------------

-- Only display ACTIVE employees who are eligible for retirement
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
on ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-----------------------------------------------------------------------------

-- Employee count by department number saved into new table called dept_emp_count
SELECT COUNT(ce.emp_no), de.dept_no, dep.dept_name
INTO dept_emp_count
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
LEFT JOIN departments as dep
ON de.dept_no = dep.dept_no
GROUP BY de.dept_no, dep.dept_name
ORDER BY de.dept_no

-----------------------------------------------------------------------------

-- List of employees containing their unique employee number, their last name,
-- first name, gender, and salary
SELECT e.emp_no,
       e.first_name,
	     e.last_name,
       e.gender,
       s.salary,
       de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	 AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
   AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-----------------------------------------------------------------------------

-- list of managers for each department, including the department number,
-- name, and the manager's employee number, last name, first name, and the
-- starting and ending employment dates.
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
from dept_manager as dm
INNER JOIN current_emp as ce
ON (dm.emp_no = ce.emp_no)
INNER JOIN departments as d
on (dm.dept_no = d.dept_no)

-----------------------------------------------------------------------------

-- An updated current_emp list that includes everything it currently has,
-- but also the employee's departments
SELECT ce.emp_no,
	     ce.first_name,
	     ce.last_name,
	     d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)

-----------------------------------------------------------------------------

-- information relevant to the Sales team. list includes:
-- Employee numbers, first name, last name, department name

SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
FROM current_emp as ce
INNER JOIN dept_employees as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales')

-----------------------------------------------------------------------------

-- information relevant to the Sales and Development team.
-- list includes:
-- Employee numbers, first name, last name, department name

SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
FROM current_emp as ce
INNER JOIN dept_employees as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development')

-----------------------------------------------------------------------------

-- Number of retiring employees by Title
SELECT DISTINCT ON (ce.emp_no)
     ce.emp_no
	   ce.first_name,
	   ce.last_name,
	   ce.to_date,
	   tt.title
FROM current_emp as ce
INNER JOIN titles as tt
ON (ce.emp_no = tt.emp_no)
ORDER BY emp_no, title DESC;

SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;
