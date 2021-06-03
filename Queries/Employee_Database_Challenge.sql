-- Deliverable 1

-- Retirement table w/ titles of current emp going to retire
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM titles AS t
LEFT JOIN employees AS e
	ON ( t.emp_no = e.emp_no )
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;



-- Most recent title of each employee in retirement_tables
-- Creates new table unique_titles
SELECT DISTINCT ON(emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC ;




-- Count number of employees retiring grouped by
-- job title from unique_titles table; New table retiring_titles
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;



-- Deliverable 2

-- Mentorship eligibility table
SELECT DISTINCT ON(emp_no) e.emp_no, e.first_name, e.last_name, 
e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_employees AS de
	ON e.emp_no=de.emp_no
LEFT JOIN titles AS t
	ON e.emp_no=t.emp_no
WHERE (de.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;