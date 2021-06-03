# Pewlett-Hackard_Analysis
Challenge 7 for UT Bootcamp - SQL Module


## Overview
In this module, we analyze a dataset for a fictious company Pewlett-Hackard. The dataset contains information on employees, managers, salaries, titles, etc. The purpose of the module is to use PostgreSQL to analyze the data, create new tables, and help the human resources department of this company to gather information on employees that are retiring in the near future as well as lay the groundwork for a mentorship program for training employees to fill the roles of people who are retiring.


## Results
Employees with birthdays in the years 1952-1955 were counted for retiring. The list below shows the title of current employees who will be retiring and the counts for each job title.

![Retiring Employees Grouped by Title](https://github.com/SG314159/Pewlett-Hackard_Analysis/blob/main/Data/retiring_titles.PNG)

There is a total of 90,398 employees retiring soon.

#### Major points to note from the data:
- The greatest need is for senior-level, regular-level, and assistant-level engineers.
- The next greatest need is for senior-level and regular-level staff.
- There is a need to train some technique leaders but that need is not as great as other job titles.
- There is not a great need to train managers as few of them are retiring.


## Summary
There are over 90,000 current employees retiring soon across engineers, staff, and technical leaders. In order to maximize the knowledge of these employees, it is recommended to implement a mentorship program for retiring employees to mentor current employees, either while still working or after retirement if available.

Initially, the mentorship program was researched for current employees who had birthdays in 1965, or about 10 years younger than the retiring employees. However, this are only 1,549 current employees who would be eligible, so that is clearly not enough people to fill the upcoming roles.

It is recommended to expand the mentorship program as follows:
- Expand the dates for people eligible to be trained in the mentor program to include younger employees. This is necessary because the titles of people requiring is not just senior (more experienced) people but also regular and associate engineers, for example. 

Two additional queries were used to study the situation:

*Query 1:* Find all current employees not in the retirement group. Call this table nonretire.
```
SELECT DISTINCT ON(emp_no) e.emp_no, e.first_name, e.last_name, 
e.birth_date, de.from_date, de.to_date, t.title
INTO nonretire
FROM employees AS e
LEFT JOIN dept_employees AS de
	ON e.emp_no=de.emp_no
LEFT JOIN titles AS t
	ON e.emp_no=t.emp_no
WHERE (de.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1956-01-01' AND '2000-12-31')
ORDER BY emp_no;
```

This returns 167,666 current employees, which is more than the number of retirees. 


*Query 2:* Find the youngest people in the non-retire group.
```
SELECT birth_date, first_name, last_name FROM nonretire
ORDER BY birth_date DESC;
```

The most recent birthday in this nonretire table is Feb 1, 1965. This means that in general the entire company is lacking in new, younger employees. Thus, in addition to expanding the mentorship program, the company needs to identify and recruit younger employees in general. A program for college internships would also be a great addition to the company.

*Query 3:* Count the job titles in the non-retire group.
```
SELECT COUNT(title), title FROM nonretire
GROUP BY title
ORDER BY COUNT(title) DESC;
```

The results are shown here.
![Non-retiring Employees Grouped by Title](https://github.com/SG314159/Pewlett-Hackard_Analysis/blob/main/Data/nonretiring_titles.PNG)

Comparing the number for the titles retiring (above) and titles of non-retiring employees, it is evident that the 14,222 Engineers retiring should immediately start mentoring the 8,403 Assistant Engineers that are not-retiring. There are no non-retiring employees with the title of Engineer, so it makes the best sense to train current Assistant Engineers to fill those rolls and focus on hiring younger, assistant engineers.



