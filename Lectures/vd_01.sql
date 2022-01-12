SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM departments;

SELECT * FROM departments WHERE MANAGER_ID=0;
UPDATE departments SET MANAGER_ID=NULL WHERE MANAGER_ID=0;

SELECT *
FROM medals
WHERE Year=2000;

SELECT MIN(Year), MAX(Year)
FROM medals;
--
SELECT Year, COUNT(*)
FROM medals
GROUP BY Year;
--
SELECT Year, COUNT(*)
FROM medals
WHERE Medal='Gold'
GROUP BY Year;
--
SELECT Year, COUNT(*) AS so_hc_vang
FROM medals
WHERE Medal='Gold'
GROUP BY Year
ORDER BY so_hc_vang DESC;

-- cho biet trong nam 2000 quoc gia nao co so hc vang nhieu nhat
SELECT CountryCode, COUNT(*) AS so_hc_vang
FROM medals
WHERE Year=2000 AND Medal='Gold'
GROUP BY CountryCode
ORDER BY so_hc_vang DESC
LIMIT 1;


-- cho biet cac nhan vien co luong >= 10000
SELECT *
FROM employees
WHERE SALARY>=10000
ORDER BY SALARY DESC;

-- cho biet cac nhan vien co last_name khong phai la King
SELECT *
FROM employees
WHERE LAST_NAME<>'King'
ORDER BY LAST_NAME;

-- cho biet cac nhan vien co hoa hong (COMMISSION_PCT co gia tri)
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NOT NULL;

SELECT COUNT(*)
FROM employees;
--
SELECT COUNT(*)
FROM employees
WHERE DEPARTMENT_ID=50;
--
SELECT DEPARTMENT_ID, COUNT(*) AS dem
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT COUNT(*), COUNT(DEPARTMENT_ID)
FROM employees;

SELECT DISTINCT DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID;

-- danh so thu tu
SELECT ROW_NUMBER() OVER(ORDER BY EMPLOYEE_ID) AS STT,
	EMPLOYEE_ID, FIRST_NAME, SALARY
FROM employees;

-- doi first_name va last_name sang chu HOA
UPDATE employees
SET FIRST_NAME=UPPER(FIRST_NAME), LAST_NAME=UPPER(LAST_NAME);

-- doi first_name va last_name sang chu HOA
UPDATE employees
SET FIRST_NAME=UPPER(FIRST_NAME), LAST_NAME=UPPER(LAST_NAME);

CREATE TABLE emp_bk
AS
	SELECT * FROM employees; -- sub query
    

-- tang luong 10% cho cac nhan vien phong 50
UPDATE employees
SET SALARY=SALARY*1.1
WHERE DEPARTMENT_ID=50;

DELETE FROM emp_bk WHERE DEPARTMENT_ID=90;

-- cho biet cac quoc gia trong the van hoi 2000 khong co huy chuong vang
SELECT *
FROM country
WHERE CountryCode NOT IN
(
    SELECT CountryCode
    FROM medals
    WHERE Year=2000 AND Medal='Gold'
);    


