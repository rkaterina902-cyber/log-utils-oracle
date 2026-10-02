create or replace PROCEDURE ADD_NEW_JOBS(
    p_job_id      IN VARCHAR2,
    p_job_title   IN VARCHAR2,
    p_min_salary  IN NUMBER,
    p_max_salary  IN NUMBER DEFAULT NULL,
    po_err        OUT VARCHAR2
) IS
    v_max_salary NUMBER;
BEGIN
    -- Якщо p_max_salary не переданий,
    -- розраховуємо його як p_min_salary * 1.5
    IF p_max_salary IS NULL THEN
        v_max_salary := p_min_salary * 1.5;
    ELSE
        v_max_salary := p_max_salary;
    END IF;

    -- Перевіряємо зарплату
    IF p_min_salary < 2000 OR v_max_salary < 2000 THEN
        po_err := 'Передана зарплата менша за 2000';
    ELSE
        INSERT INTO JOBS (
            JOB_ID,
            JOB_TITLE,
            MIN_SALARY,
            MAX_SALARY
        )
        VALUES (
            p_job_id,
            p_job_title,
            p_min_salary,
            v_max_salary
        );

        po_err := 'Посада ' || p_job_id || ' успішно додана';
    END IF;
END ADD_NEW_JOBS;
