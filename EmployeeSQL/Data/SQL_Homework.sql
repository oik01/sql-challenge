-- Create Tables and assign keys/ foreign keys 
CREATE TABLE "Departments" (
    "dept_no" int   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" int   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

CREATE INDEX "idx_Departments_dept_name"
ON "Departments" ("dept_name");

CREATE INDEX "idx_employees_first_name"
ON "employees" ("first_name");

CREATE INDEX "idx_employees_last_name"
ON "employees" ("last_name");




-- List the following details of each employee: employee number, last name, first name, gender, and salary.

Select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary from employees join salaries on employees.emp_no= salaries.emp_no

-- List employees who were hired in 1986.

Select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary from employees join salaries on employees.emp_no= salaries.emp_no where extract (year from employees.hire_date) = 1986

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
Select dept_manager.dept_no, "Departments".dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
From "Departments" join "dept_manager"  on dept_manager.dept_no = "Departments".dept_no 
join "employees" on  dept_manager.emp_no= employees.emp_no;
-- List the department of each employee with the following information: employee number, last name, first name, and department name.
Select employees.emp_no, employees.last_name, employees.first_name, "Departments".dept_name
From employees join dept_emp on employees.emp_no = dept_emp.emp_no
join "Departments" on dept_emp.dept_no = "Departments".dept_no
-- List all employees whose first name is "Hercules" and last names begin with "B."
Select emp_no, last_name, first_name
From Employees
where first_name = 'Hercules' and left(last_name, 1) = 'B'
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select employees.emp_no, employees.last_name, employees.first_name, "Departments".dept_name
From employees join dept_emp on employees.emp_no = dept_emp.emp_no
join "Departments" on dept_emp.dept_no = "Departments".dept_no
where "Departments".dept_name = 'Sales'
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select employees.emp_no, employees.last_name, employees.first_name, "Departments".dept_name
From employees join dept_emp on employees.emp_no = dept_emp.emp_no
join "Departments" on dept_emp.dept_no = "Departments".dept_no
where "Departments".dept_name = 'Sales' or "Departments".dept_name = 'Development'
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
Select last_name, count(last_name)
From employees
group by last_name
order by count (last_name) Desc;
