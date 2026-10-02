
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."STUDENTS_DEP_V" ("STUDENT_ID", "DEPARTMENT_NAME", "TEACHER_ID", "START_DATE", "FULL_NAME", "SCHOLARSHIP") AS 
  select 
    st.student_id,
    dp.department_name,
    st.teacher_id,
    st.start_date,
    st.full_name,
    st.scholarship
from katerina_blz.students st
join katerina_blz.departments dp 
    on st.department_id = dp.department_id;


  GRANT SELECT ON "KATERINA_BLZ"."STUDENTS_DEP_V" TO "HR";
