CREATE OR REPLACE EDITIONABLE PACKAGE BODY "KATERINA_BLZ"."UTIL" AS

    FUNCTION get_region_cnt_emp(
        p_department_id IN departments.department_id%TYPE DEFAULT NULL
    ) RETURN region_cnt_emp_tab PIPELINED
    IS
        l_row region_cnt_emp_rec;
    BEGIN
        FOR rec IN (
            SELECT
                r.region_id,
                r.region_name,
                COUNT(em.employee_id) AS employee_count
            FROM regions r
                LEFT JOIN countries c
                    ON c.region_id = r.region_id
                LEFT JOIN locations l
                    ON l.country_id = c.country_id
                LEFT JOIN departments d
                    ON d.location_id = l.location_id
                LEFT JOIN employees em
                    ON em.department_id = d.department_id
            WHERE (em.department_id = p_department_id
                   OR p_department_id IS NULL)
            GROUP BY r.region_id, r.region_name
            ORDER BY r.region_id
        )
        LOOP
            l_row.region_id      := rec.region_id;
            l_row.region_name    := rec.region_name;
            l_row.employee_count := rec.employee_count;

            PIPE ROW (l_row);
        END LOOP;

        RETURN;
    END get_region_cnt_emp;

END util;
/
