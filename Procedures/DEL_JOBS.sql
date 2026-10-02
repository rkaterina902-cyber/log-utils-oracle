create or replace PROCEDURE del_jobs(
    p_job_id  IN VARCHAR2,
    po_result OUT VARCHAR2
) IS
    v_delete_no_data_found EXCEPTION;
BEGIN
    BEGIN
        DELETE FROM jobs
        WHERE job_id = p_job_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE v_delete_no_data_found;
        END IF;

        po_result := 'Посада ' || p_job_id || ' успішно видалена';

    EXCEPTION
        WHEN v_delete_no_data_found THEN
            RAISE_APPLICATION_ERROR(
                -20004,
                'Посада ' || p_job_id || ' не існує'
            );
    END;
END del_jobs;
