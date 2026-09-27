CREATE OR REPLACE EDITIONABLE PROCEDURE "KATERINA_BLZ"."DOWNLOAD_IBANK_INDEX_UA" IS
BEGIN
    INSERT INTO interbank_index_ua_history
    (
        dt,
        id_api,
        value,
        special
    )
    SELECT
        dt,
        id_api,
        value,
        special
    FROM interbank_index_ua_v;

    COMMIT;
END download_ibank_index_ua;
/
