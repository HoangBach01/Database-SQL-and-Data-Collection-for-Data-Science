SELECT *
FROM employees
WHERE SALARY< ALL
(SELECT SALARY FROM employees WHERE LAST_NAME='King');

SELECT *
FROM employees
WHERE SALARY< ANY
(SELECT SALARY FROM employees WHERE LAST_NAME='King');

-- cho biet cac phong khong co nhan vien
SELECT *
FROM departments
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM employees);

SELECT *
FROM departments
WHERE DEPARTMENT_ID NOT IN 
(SELECT DISTINCT DEPARTMENT_ID FROM employees WHERE DEPARTMENT_ID IS NOT NULL);

-- cho biet danh sach cac truong phong
SELECT *
FROM employees
WHERE EMPLOYEE_ID IN 
(SELECT MANAGER_ID FROM departments WHERE MANAGER_ID IS NOT NULL);

-- cho biet danh sach cac truong phong
CREATE OR REPLACE VIEW v_depmgr
AS
    SELECT *
    FROM employees
    WHERE EMPLOYEE_ID IN 
    (SELECT MANAGER_ID FROM departments WHERE MANAGER_ID IS NOT NULL);

-- cho biet luong lon nhat cua 10 quan ly
SELECT *
FROM employees
WHERE EMPLOYEE_ID IN 
(SELECT DISTINCT MANAGER_ID FROM employees WHERE MANAGER_ID IS NOT NULL)
ORDER BY SALARY DESC
LIMIT 10;

-- cho biet luong lon nhat, luong nho nhat, luong trung binh cua cac quan ly
SELECT MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM employees
WHERE EMPLOYEE_ID IN 
(SELECT DISTINCT MANAGER_ID FROM employees WHERE MANAGER_ID IS NOT NULL);

-- cho biet cac nhan vien lam viec o thanh pho Seattle
SELECT *
FROM employees
WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID FROM departments WHERE location_id IN
 (SELECT location_id FROM locations WHERE city='Seattle'));

SELECT * FROM `locations` WHERE country_id='CA';
SELECT * FROM departments
WHERE LOCATION_ID IN
(SELECT LOCATION_ID FROM `locations` WHERE country_id='CA');

SELECT *
FROM employees
WHERE department_id IN
(
SELECT department_id FROM departments
WHERE LOCATION_ID IN
(SELECT LOCATION_ID FROM `locations` WHERE country_id='CA'));

-- thong ke so nhan vien theo cac nam vao lam
SELECT YEAR(HIRE_DATE), COUNT(*) AS dem
FROM employees
GROUP BY YEAR(HIRE_DATE);

-- thong ke so nhan vien theo cac nam vao lam
-- loc ra cac nam co so nhan vien vao lam > 10
SELECT YEAR(HIRE_DATE), COUNT(*) AS dem
FROM employees
GROUP BY YEAR(HIRE_DATE)
HAVING COUNT(*)>10;

SELECT *
FROM
(
    SELECT YEAR(HIRE_DATE), COUNT(*) AS dem
    FROM employees
    GROUP BY YEAR(HIRE_DATE)
) q
WHERE dem>10;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, employees.DEPARTMENT_ID, department_name
FROM employees, departments
WHERE employees.DEPARTMENT_ID=departments.DEPARTMENT_ID;

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.department_name
FROM employees e, departments d
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID; -- 106
--
SELECT * FROM employees WHERE DEPARTMENT_ID IS NULL;


SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.department_name
FROM employees e INNER JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;

SELECT d.*, e.FIRST_NAME, e.LAST_NAME
FROM departments d JOIN employees e ON d.MANAGER_ID=e.EMPLOYEE_ID;

SELECT d.*, e.FIRST_NAME, e.LAST_NAME
FROM departments d LEFT OUTER JOIN employees e ON d.MANAGER_ID=e.EMPLOYEE_ID;

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.department_name
FROM employees e LEFT JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;

-- cho biet cac phong khong co nhan vien
SELECT d.*
FROM departments d LEFT OUTER JOIN employees e ON d.DEPARTMENT_ID=e.DEPARTMENT_ID
WHERE e.EMPLOYEE_ID IS NULL;



