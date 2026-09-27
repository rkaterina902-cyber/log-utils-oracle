CREATE OR REPLACE EDITIONABLE PACKAGE "KATERINA_BLZ"."UTIL" AS

    TYPE region_cnt_emp_rec IS RECORD (
        region_id      NUMBER,
        region_name    VARCHAR2(100),
        employee_count NUMBER
    );

    TYPE region_cnt_emp_tab IS TABLE OF region_cnt_emp_rec;

    FUNCTION get_region_cnt_emp(
        p_department_id IN NUMBER DEFAULT NULL
    ) RETURN region_cnt_emp_tab PIPELINED;

END util;
/
