-- ============================================================
-- TEST_ADD_EMPLOYEE.sql
-- Перевірка процедури UTIL.ADD_EMPLOYEE
-- ============================================================

SET SERVEROUTPUT ON;

-- ============================================================
-- ТЕСТ 1. Успішне додавання співробітника
-- ============================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('ТЕСТ 1: Успішне додавання співробітника');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    UTIL.ADD_EMPLOYEE(
        p_first_name     => 'Test',
        p_last_name      => 'Employee',
        p_email          => 'TEST_EMPLOYEE',
        p_phone_number   => '123.456.7890',
        p_hire_date      => TRUNC(SYSDATE),
        p_job_id         => 'IT_PROG',
        p_salary         => 6000,
        p_commission_pct => NULL,
        p_manager_id     => 100,
        p_department_id  => '60'
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Помилка: ' || SQLERRM);
END;
/

-- Перевіряємо, чи співробітник додався
SELECT employee_id,
       first_name,
       last_name,
       email,
       job_id,
       salary,
       department_id
FROM employees
WHERE email = 'TEST_EMPLOYEE';


-- ============================================================
-- ТЕСТ 2. Неіснуючий JOB_ID
-- ============================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('ТЕСТ 2: Неіснуючий код посади');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    UTIL.ADD_EMPLOYEE(
        p_first_name     => 'Test',
        p_last_name      => 'WrongJob',
        p_email          => 'WRONG_JOB',
        p_phone_number   => '123.456.7890',
        p_hire_date      => TRUNC(SYSDATE),
        p_job_id         => 'WRONG_JOB',
        p_salary         => 6000,
        p_commission_pct => NULL,
        p_manager_id     => 100,
        p_department_id  => '60'
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Очікувана помилка: ' || SQLERRM);
END;
/


-- ============================================================
-- ТЕСТ 3. Неіснуючий DEPARTMENT_ID
-- ============================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('ТЕСТ 3: Неіснуючий ідентифікатор відділу');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    UTIL.ADD_EMPLOYEE(
        p_first_name     => 'Test',
        p_last_name      => 'WrongDepartment',
        p_email          => 'WRONG_DEPARTMENT',
        p_phone_number   => '123.456.7890',
        p_hire_date      => TRUNC(SYSDATE),
        p_job_id         => 'IT_PROG',
        p_salary         => 6000,
        p_commission_pct => NULL,
        p_manager_id     => 100,
        p_department_id  => '9999'
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Очікувана помилка: ' || SQLERRM);
END;
/


-- ============================================================
-- ТЕСТ 4. Зарплата поза допустимим діапазоном
-- ============================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('ТЕСТ 4: Неприпустима заробітна плата');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    UTIL.ADD_EMPLOYEE(
        p_first_name     => 'Test',
        p_last_name      => 'WrongSalary',
        p_email          => 'WRONG_SALARY',
        p_phone_number   => '123.456.7890',
        p_hire_date      => TRUNC(SYSDATE),
        p_job_id         => 'IT_PROG',
        p_salary         => 1,
        p_commission_pct => NULL,
        p_manager_id     => 100,
        p_department_id  => '60'
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Очікувана помилка: ' || SQLERRM);
END;
/


-- ============================================================
-- ТЕСТ 5. Перевірка значень за замовчуванням
-- p_hire_date = TRUNC(SYSDATE)
-- p_commission_pct = NULL
-- p_manager_id = 100
-- ============================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('ТЕСТ 5: Значення параметрів за замовчуванням');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    UTIL.ADD_EMPLOYEE(
        p_first_name    => 'Test',
        p_last_name     => 'Defaults',
        p_email         => 'TEST_DEFAULTS',
        p_phone_number  => '123.456.7890',
        p_job_id        => 'IT_PROG',
        p_salary        => 6000,
        p_department_id => '60'
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Помилка: ' || SQLERRM);
END;
/

-- Перевірка результату
SELECT employee_id,
       first_name,
       last_name,
       hire_date,
       job_id,
       salary,
       commission_pct,
       manager_id,
       department_id
FROM employees
WHERE email = 'TEST_DEFAULTS';


-- ============================================================
-- ПІДСУМКОВА ПЕРЕВІРКА
-- ============================================================

DBMS_OUTPUT.PUT_LINE(CHR(10));
DBMS_OUTPUT.PUT_LINE('==========================================');
DBMS_OUTPUT.PUT_LINE('ПЕРЕВІРКА ЗАВЕРШЕНА');
DBMS_OUTPUT.PUT_LINE('==========================================');

SELECT employee_id,
       first_name,
       last_name,
       email,
       job_id,
       salary,
       department_id
FROM employees
WHERE email IN (
    'TEST_EMPLOYEE',
    'TEST_DEFAULTS'
)
ORDER BY employee_id;
