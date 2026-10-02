  CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."FULL_DETAIL_EMP" ("FIRST_NAME", "LAST_NAME", "PHONE_NUMBER", "HIRE_DATE", "JOB_TITLE", "SALARY", "DEPARTMENT_NAME", "LOCATION_ID", "CITY", "STREET_ADDRESS", "POSTAL_CODE") AS 
  select em.first_name, 
       em.last_name,
       em.phone_number, 
       em.hire_date,
       j.job_title,
       salary, 
       nvl(dp.department_name, 'Dep not defined') as department_name, 
       nvl(dp.location_id,0) as location_id,
       nvl(ct.city,'Not defined') as city,
       nvl(ct.street_address,'Not defined') as street_address,
       nvl(ct.postal_code,'Not defined') as postal_code
 from hr.employees em
 left join hr.departments dp
 on em.department_id = dp.department_id
 join hr.jobs j
 on em.job_id = j.job_id
 left join hr.locations ct
 on dp.location_id = ct.location_id
 order by em.employee_id;
