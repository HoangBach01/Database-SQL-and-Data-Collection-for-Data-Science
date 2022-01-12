SELECT * FROM petsale;
SELECT AVG(saleprice) FROM petsale;

-- cho biet cac con thu co tong tien ban > trung binh cac tong tien ban
SELECT * FROM petsale
WHERE saleprice > (SELECT AVG(saleprice) FROM petsale);

SELECT animal, saleprice, (SELECT AVG(saleprice) FROM petsale)
FROM petsale;

SELECT animal,quantity,saleprice,
	(SELECT SUM(saleprice) FROM petsale WHERE animal='Dog') AS tong,
    (SELECT AVG(saleprice) FROM petsale WHERE animal='Dog') AS trungbinh
FROM petsale
WHERE animal='Dog';

SELECT SUM(saleprice), COUNT(*), AVG(saleprice), SUM(saleprice)/COUNT(*)
FROM `petsale`
WHERE animal='Dog';

--
SELECT AVG(saleprice/quantity), SUM(saleprice)/SUM(quantity)
FROM `petsale`
WHERE animal='Dog';

SELECT * FROM `employees` WHERE last_name='Kochhar';
-- cho biet cac nhan vien lam cung phong voi Kochhar
SELECT *
FROM employees
WHERE DEPARTMENT_ID =
(SELECT DEPARTMENT_ID FROM `employees` WHERE last_name='Kochhar');

SELECT * FROM `employees` WHERE last_name='King';
-- cho biet cac nhan vien lam cung phong voi King
SELECT *
FROM employees
WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID FROM `employees` WHERE last_name='King');

-- cho biet cac nhan vien co luong lon nhat, luong nho nhat
SELECT * FROM employees WHERE SALARY=(SELECT MAX(salary) FROM employees)
UNION
SELECT * FROM employees WHERE SALARY=(SELECT MIN(salary) FROM employees);

-- truy van con ket hop correlative sub query
/*
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,
	(SELECT COUNT(*) FROM employees WHERE DEPARTMENT_ID=d.DEPARTMENT_ID)
FROM departments d; */
-- cho biet ten cac truong phong
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID,
	(SELECT FIRST_NAME FROM employees WHERE EMPLOYEE_ID=d.MANAGER_ID)
FROM departments d;


-- 1. cho biet nhan vien co luong lon nhat
SELECT * FROM employees 
WHERE SALARY=(SELECT MAX(SALARY) FROM employees);
-- 2. cho biet nhan vien co luong lon nhat trong phong 80
SELECT * FROM employees 
WHERE SALARY=(SELECT MAX(SALARY) FROM employees WHERE DEPARTMENT_ID=80)
AND DEPARTMENT_ID=80;

-- 3. cho biet cac nhan vien co luong lon nhat trong moi phong
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY
FROM employees e
WHERE SALARY = 
(SELECT MAX(SALARY) FROM employees WHERE DEPARTMENT_ID=e.DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;

-- 3. cho biet cac nhan vien co luong lon nhat trong moi phong
/*
-- correlative sub query
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY
FROM employees e
WHERE SALARY = 
(SELECT MAX(SALARY) FROM employees WHERE DEPARTMENT_ID=e.DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;
*/
-- sub query
SELECT CONCAT(DEPARTMENT_ID,'-',MAX(SALARY)) FROM employees 
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;
--
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY
FROM employees
WHERE CONCAT(DEPARTMENT_ID,'-',SALARY) IN
(
	SELECT CONCAT(DEPARTMENT_ID,'-',MAX(SALARY)) FROM employees 
	WHERE DEPARTMENT_ID IS NOT NULL
	GROUP BY DEPARTMENT_ID    
)
ORDER BY DEPARTMENT_ID;


