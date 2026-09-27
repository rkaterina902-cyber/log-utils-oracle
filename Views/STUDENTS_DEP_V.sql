CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."STUDENTS_DEP_V"
(
    "STUDENT_ID",
    "DEPARTMENT_NAME",
    "TEACHER_ID",
    "START_DATE",
    "FULL_NAME",
    "SCHOLARSHIP"
) AS
SELECT
    st.student_id,
    dp.department_name,
    st.teacher_id,
    st.start_date,
    st.full_name,
    st.scholarship
FROM katerina_blz.students st
JOIN katerina_blz.departments dp
    ON st.department_id = dp.department_id;
