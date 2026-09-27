CREATE OR REPLACE FORCE EDITIONABLE VIEW "KATERINA_BLZ"."INTERBANK_INDEX_UA_V"
(
    "DT",
    "ID_API",
    "VALUE",
    "SPECIAL"
) AS
SELECT
    TO_DATE(tt.dt, 'DD.MM.YYYY') AS dt,
    tt.id_api,
    tt.value,
    tt.special
FROM
(
    SELECT sys.get_nbu(
        p_url => 'https://bank.gov.ua/NBU_uonia?id_api=UONIA_UnsecLoansDepo&json'
    ) AS json_value
    FROM dual
) src
CROSS JOIN JSON_TABLE
(
    src.json_value,
    '$[*]'
    COLUMNS
    (
        dt       VARCHAR2(20)  PATH '$.dt',
        id_api   VARCHAR2(100) PATH '$.id_api',
        value    NUMBER        PATH '$.value',
        special  VARCHAR2(1)   PATH '$.special'
    )
) tt;
