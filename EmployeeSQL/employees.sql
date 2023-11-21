/*
-- Drop existing tables
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Create tables
CREATE TABLE departments (
    dept_no character varying(50) NOT NULL,
    dept_name character varying(50) NOT NULL
);

CREATE TABLE dept_emp (
    emp_no integer NOT NULL,
    dept_no character varying(50) NOT NULL
);

CREATE TABLE dept_manager (
    dept_no character varying(50) NOT NULL,
    emp_no integer NOT NULL
);

CREATE TABLE employees (
    emp_no integer NOT NULL,
    emp_title_id character varying(400000) NOT NULL,
    birth_date date NOT NULL,
    first_name character varying(400000),
    last_name character varying(400000),
    sex character varying(400000),
    hire_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE salaries (
    emp_no integer NOT NULL,
    salary integer NOT NULL
);

CREATE TABLE titles (
    title_id character varying(50) NOT NULL,
    title character varying(50) NOT NULL
);


SELECT * FROM departments

SELECT * FROM dept_emp

SELECT * FROM dept_manager

SELECT * FROM employees

-- Change data type of the hire_date column in the employees table
ALTER TABLE employees
ALTER COLUMN hire_date TYPE date;

SELECT * FROM employees

SELECT * FROM salaries 

SELECT * FROM titles 

--List the employee number, last name, first name, sex, and salary of each employee

SELECT 
    employees.emp_no,
    employees.birth_date,
    employees.first_name,
    employees.last_name,
    employees.sex,
    employees.hire_date,
    salaries.salary
FROM employees 
JOIN salaries ON employees.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT 
    employees.first_name,
    employees.last_name,
    employees.hire_date

FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name

SELECT 
	departments.dept_no,
	departments.dept_name,
	dept_manager.emp_no AS Manager_Emp_No,
	employees.first_name AS Manager_First_Name,
	employees.last_name AS Manager_Last_Name
	
FROM departments
JOIN  
	dept_manager ON departments.dept_no = dept_manager.dept_no

JOIN
	employees ON dept_manager.emp_no = employees.emp_no;
	
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name	
	
SELECT 
	dept_emp.dept_no AS department_number,
	dept_emp.emp_no AS employee_number,
	employees.first_name,
	employees.last_name,
	departments.dept_name AS department_name
	
FROM dept_emp
JOIN  
	employees ON employees.emp_no = dept_emp.emp_no
JOIN 
	departments ON dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT 
    employees.first_name,
    employees.last_name,
    employees.sex
FROM 
    employees
WHERE 
    employees.first_name = 'Hercules' AND 
    employees.last_name LIKE 'B%';	

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
	departments.dept_name, 
	employees.first_name,
	employees.last_name, 
	employees.emp_no
FROM 
	departments
JOIN 
	dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN
	employees ON dept_emp.emp_no = employees.emp_no
WHERE
	departments.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
	departments.dept_name, 
	employees.first_name,
	employees.last_name, 
	employees.emp_no
FROM 
	departments
JOIN 
	dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN
	employees ON dept_emp.emp_no = employees.emp_no
WHERE
	departments.dept_name IN ('Sales', 'Development');
	
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).	
	
SELECT
    last_name,
    COUNT(*) AS name_count
FROM
    employees
GROUP BY
    last_name
ORDER BY
    name_count DESC;

*/
