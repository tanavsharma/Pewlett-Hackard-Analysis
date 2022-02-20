-- Deliverable 1

-- Create new table for retiring employees
SELECT ee.emp_no,
     ee.first_name,
	   ee.last_name,
	   tt.title,
	   tt.from_date,
	   tt.to_date
INTO retirement_titles
FROM employees as ee
INNER JOIN titles as tt
ON (ee.emp_no = tt.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY ee.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
     rt.emp_no,
	   rt.first_name,
	   rt.last_name,
	   rt.to_date,
	   rt.title
FROM retirements_titles as rt
ON (ce.emp_no = tt.emp_no)
ORDER BY emp_no, title DESC;

-- number of employees by their most recent job title who are about to retire
SELECT COUNT(title), title
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

-- Deliverable 2
SELECT DISTINCT ON (ee.emp_no)
	   ee.emp_no,
	   ee.first_name,
	   ee.last_name,
	   ee.birth_date,
	   de.from_date,
	   de.to_date,
	   tt.title
INTO mentorship_eligibilty
FROM employees as ee
INNER JOIN dept_employees as de
ON (ee.emp_no = de.emp_no)
INNER JOIN titles as tt
ON (ee.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (ee.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY ee.emp_no
