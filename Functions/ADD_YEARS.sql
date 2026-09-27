CREATE OR REPLACE EDITIONABLE FUNCTION "KATERINA_BLZ"."ADD_YEARS" (
    p_date IN DATE,
    p_year IN NUMBER
) RETURN DATE IS

    v_date DATE;
    v_year NUMBER := p_year * 12;

BEGIN

    SELECT ADD_MONTHS(p_date, v_year)
    INTO v_date
    FROM dual;

    RETURN v_date;

END add_years;
/
