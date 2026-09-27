CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."REP_PROJECT_DEP_V"
(
    "PROJECT_ID",
    "PROJECT_NAME",
    "DEPARTMENT_NAME",
    "EMPLOYEE_COUNT",
    "MANAGER_COUNT",
    "TOTAL_SALARY"
) AS
SELECT
    p.project_id,
    p.project_name,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COUNT(DISTINCT e.manager_id) AS manager_count,
    NVL(SUM(e.salary), 0) AS total_salary
FROM projects_ext p
LEFT JOIN departments d
    ON d.department_id = p.department_id
LEFT JOIN employees e
    ON e.department_id = p.department_id
GROUP BY
    p.project_id,
    p.project_name,
    d.department_name;
