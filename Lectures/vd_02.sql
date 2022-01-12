SELECT `Discipline`, `Athlete`, `Medal`
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`='USA' AND `Medal`='Gold'
ORDER BY `Discipline`, `Athlete`;

SELECT ROW_NUMBER() OVER(ORDER BY `Discipline`, `Athlete`) AS STT,
	`Discipline`, `Athlete`, `Medal`
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`='USA' AND `Medal`='Gold';

SELECT ROW_NUMBER() OVER(PARTITION BY `Discipline` ORDER BY `Athlete`) AS STT,
	`Discipline`, `Athlete`, `Medal`
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`='USA' AND `Medal`='Gold';

SELECT `CountryCode`, COUNT(*) AS so_hc
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`!=''
GROUP BY `CountryCode`;

SELECT `CountryCode`, COUNT(*) AS so_hc
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`!=''
GROUP BY `CountryCode`
ORDER BY so_hc DESC;

SELECT `CountryCode`, `Medal`, COUNT(*) AS so_hc
FROM `medals` 
WHERE `Year`=2012 AND `CountryCode`!=''
GROUP BY `CountryCode`, `Medal`
ORDER BY `CountryCode`, `Medal`;

SELECT Year, COUNT(*) AS so_hcv
FROM `medals` 
WHERE Medal='Gold' AND CountryCode!=''
GROUP BY Year
ORDER BY so_hcv DESC
LIMIT 1;

    (SELECT Year, COUNT(*) AS so_hcv
    FROM `medals` 
    WHERE Medal='Gold' AND CountryCode!=''
    GROUP BY Year
    ORDER BY so_hcv DESC
    LIMIT 1)
    UNION   
    (
    SELECT Year, COUNT(*) AS so_hcv
    FROM `medals` 
    WHERE Medal='Gold' AND CountryCode!=''
    GROUP BY Year
    ORDER BY so_hcv 
    LIMIT 1);

    (SELECT Year, COUNT(*) AS so_hcv, 'nhieu nhat' AS note
    FROM `medals` 
    WHERE Medal='Gold' AND CountryCode!=''
    GROUP BY Year
    ORDER BY so_hcv DESC
    LIMIT 1)
    UNION   
    (
    SELECT Year, COUNT(*) AS so_hcv, 'it nhat'
    FROM `medals` 
    WHERE Medal='Gold' AND CountryCode!=''
    GROUP BY Year
    ORDER BY so_hcv 
    LIMIT 1);

SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND CountryCode!='' AND Gender='women' AND Medal='Gold'
GROUP BY CountryCode
HAVING COUNT(*)>=20;

-- tinh cac tong luong theo moi phong
SELECT department_id, SUM(salary) AS sum_sal
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

-- tinh cac tong luong theo moi phong
SELECT department_id, job_id, SUM(salary) AS sum_sal, COUNT(*) AS count_emp
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id;

-- thong ke so nhan vien teho cac nam vao lam
SELECT YEAR(hire_date) AS nam, COUNT(*) AS count_emp
FROM employees
GROUP BY YEAR(hire_date);

-- thong ke so nhan vien teho cac nam vao lam
SELECT YEAR(hire_date) AS nam, COUNT(*) AS count_emp
FROM employees
GROUP BY YEAR(hire_date)
HAVING COUNT(*)>10;

-- SELECT SUM(`saleprice`) FROM `petsale` WHERE 1;
SELECT SUM(`saleprice`) FROM `petsale` 
WHERE Month(`saledate`)=6 AND Year(`saledate`)=2020;

SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT Year(`saledate`), SUM(`saleprice`) 
FROM `petsale` 
GROUP BY Year(`saledate`);

-- tinh trung binh cua cac tong luong teho phong
SELECT AVG(sum_sal)
FROM
(
 	SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal
    FROM employees
    WHERE DEPARTMENT_ID IS NOT NULL
    GROUP BY DEPARTMENT_ID
) q;


-- view la bang ao
CREATE OR REPLACE VIEW myview
AS
	SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal
    FROM employees
    WHERE DEPARTMENT_ID IS NOT NULL
    GROUP BY DEPARTMENT_ID;

SELECT AVG(sum_sal) FROM myview;

    