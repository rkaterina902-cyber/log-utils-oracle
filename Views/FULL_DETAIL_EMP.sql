CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."FULL_DETAIL_EMP"
(
    "FIRST_NAME",
    "LAST_NAME",
    "PHONE_NUMBER",
    "HIRE_DATE",
    "JOB_TITLE",
    "SALARY",
    "DEPARTMENT_NAME",
    "LOCATION_ID",
    "CITY",
    "STREET_ADDRESS",
    "POSTAL_CODE"
) AS
SELECT
    em.first_name,
    em.last_name,
    em.phone_number,
    em.hire_date,
    j.job_title,
    salary,
    NVL(dp.department_name, 'Dep not defined') AS department_name,
    NVL(dp.location_id, 0) AS location_id,
    NVL(ct.city, 'Not defined') AS city,
    NVL(ct.street_address, 'Not defined') AS street_address,
    NVL(ct.postal_code, 'Not defined') AS postal_code
FROM hr.employees em
LEFT JOIN hr.departments dp
    ON em.department_id = dp.department_id
JOIN hr.jobs j
    ON em.job_id = j.job_id
LEFT JOIN hr.locations ct
    ON dp.location_id = ct.location_id
ORDER BY em.employee_id;
