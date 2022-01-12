USE TestDB;
SELECT D.department_name AS department,
    E.first_name AS employee_first_name,
    E.last_name AS employee_last_name,
    E.salary AS salary
FROM employees E
    INNER JOIN departments D ON E.department_id = D.department_id
WHERE (
        SELECT COUNT(DISTINCT(salary))
        FROM employees
        WHERE department_id = E.department_id
            AND salary > E.salary
    ) < 5
ORDER BY E.department_id,
    E.salary DESC;