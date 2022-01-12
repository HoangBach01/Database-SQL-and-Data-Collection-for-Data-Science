-- xem cac db trong mysql
SHOW DATABASES;
SELECT * FROM information_schema.schemata;

-- xem cac table trong db
SHOW TABLE STATUS FROM hr;
-- xem cac column trong table
SHOW COLUMNS FROM employees;
DESCRIBE hr.employees;

-- truy van cac table trong db
SELECT * FROM information_schema.tables;
SELECT * FROM information_schema.tables WHERE table_schema='hr';
-- truy van cac column trong table
SELECT * FROM information_schema.columns
SELECT * FROM information_schema.columns WHERE table_schema='hr' AND table_name='employees';
-- truy van cac constraint
SELECT * FROM information_schema.table_constraints;

-- tao cac constraint
ALTER TABLE departments
ADD CONSTRAINT pk_dep PRIMARY KEY(department_id);

ALTER TABLE employees
ADD CONSTRAINT pk_emp PRIMARY KEY(EMPLOYEE_ID);

ALTER TABLE employees
ADD CONSTRAINT ck_emp_salary CHECK(SALARY>0);

ALTER TABLE employees
ADD CONSTRAINT fk_emp_dep FOREIGN KEY(department_id) REFERENCES departments(department_id);

-- truy van tat ca constraint trong tat ca table trong tat ca db
SELECT * FROM information_schema.table_constraints WHERE table_schema='hr'

select COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
from information_schema.KEY_COLUMN_USAGE
where TABLE_NAME = 'employees';

-- truy van cac primary key constraint
SELECT * FROM information_schema.statistics;

SELECT * FROM information_schema.statistics 
WHERE index_name = 'primary' AND table_schema='hr'

-- truy van cac foreign key constraint
SELECT TABLE_NAME,
       COLUMN_NAME,
       CONSTRAINT_NAME,
       REFERENCED_TABLE_NAME,
       REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'hr'
      AND TABLE_NAME = 'employees'
      AND REFERENCED_COLUMN_NAME IS NOT NULL;

-- truy van cac check constraint
SELECT * FROM information_schema.check_constraints;


