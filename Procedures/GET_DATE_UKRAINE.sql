CREATE OR REPLACE EDITIONABLE PROCEDURE "KATERINA_BLZ"."GET_DATE_UKRAINE" IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'В України зараз: ' ||
        TO_CHAR(SYSDATE, 'dd.mm.yyyy hh24:mi:ss')
    );
END get_date_ukraine;
/
