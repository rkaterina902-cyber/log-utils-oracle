-- ============================================================
-- TEST LOG_UTILS
-- ============================================================

BEGIN
    log_utils.log_start(
        p_proc_name => 'TEST_LOG_UTILS'
    );
END;
/

BEGIN
    log_utils.log_finish(
        p_proc_name => 'TEST_LOG_UTILS'
    );
END;
/

BEGIN
    log_utils.log_error(
        p_proc_name => 'TEST_LOG_UTILS',
        p_sqlerrm   => 'Тестова помилка'
    );
END;
/

SELECT appl_proc,
       message,
       log_date
FROM logs
WHERE appl_proc = 'TEST_LOG_UTILS'
ORDER BY log_date DESC;
