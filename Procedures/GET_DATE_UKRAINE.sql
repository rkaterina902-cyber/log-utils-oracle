create or replace PROCEDURE get_date_ukraine IS
BEGIN
dbms_output.put_line('В України зараз: ' || to_char(sysdate,
'dd.mm.yyyy hh24:mi:ss'));
END get_date_ukraine;
