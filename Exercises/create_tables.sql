CREATE TABLE departments
(
    department_id int primary key,
    department_name text not null unique,
    manager_id int,
    location_id int
);
CREATE TABLE employees
(
    employee_id int primary key,
    first_name text not null,
    last_name text not null,
    email text,
    phone_number text,
    hire_date text,
    job_id text,
    salary numeric,
    commission_pct numeric,
    manager_id int,
    department_id int
);

