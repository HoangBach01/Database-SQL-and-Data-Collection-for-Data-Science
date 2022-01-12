DROP DATABASE IF EXISTS chap_1;
CREATE DATABASE chap_1;
CREATE TABLE chap_1.Employees (
    id INT(3) AUTO_INCREMENT PRIMARY KEY,
    full_name varchar(150) NOT NULL,
    data_of_birth Date,
    gender boolean,
    salary decimal(8, 2)
);
INSERT INTO chap_1.Employees (full_name, data_of_birth, gender, salary)
VALUES ('Donald Trump', '1946-06-14', TRUE, 24000),
    ('Barack Obama', '1961-08-04', TRUE, 20000),
    (
        'Hillary Rodham Clinton',
        '1947-10-26',
        False,
        20000
    );
SELECT *
FROM chap_1.Employees;
DROP TABLE IF EXISTS chap_1.Employees;
CREATE TABLE chap_1.Employees (
    EMPLOYEE_ID integer PRIMARY KEY NOT NULL,
    FIRST_NAME varchar(150) NOT NULL,
    LAST_NAME varchar(150) NOT NULL,
    EMAIL varchar(150),
    PHONE_NUMBER varchar(40),
    HIRE_DATE Date,
    JOB_ID varchar(150),
    SALARY decimal(15, 2),
    COMMISSION_PCT float,
    MANAGER_ID integer,
    DEPARTMENT_ID integer
);
LOAD DATA LOCAL INFILE '/Users/tranhoangbach/Working Hub/Trung tam TH/4. Database and SQL/data/data_humanreources/employees.csv' INTO TABLE chap_1.Employees FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
UPDATE chap_1.Employees
SET department_id = NULL
WHERE department_id = 0;
UPDATE chap_1.Employees
SET manager_id = NULL
WHERE manager_id = 0;
SELECT *
FROM chap_1.Employees;