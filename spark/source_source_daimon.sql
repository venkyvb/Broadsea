truncate ohdsi.source;

truncate ohdsi.source_daimon;

INSERT INTO
    webapi.source(
        source_id,
        source_name,
        source_key,
        source_connection,
        source_dialect,
        is_cache_enabled
    )
VALUES (
        7,
        'ADB_OMOP_7',
        'ADB_OMOP_7',
        'jdbc:spark://adb-xxxxxxxxxxxxxxx.10.azuredatabricks.net:443/default;transportMode=http;ssl=1;httpPath=sql/protocolv1/o/xxxxxxxxxxxxxxx/0309-002413-fvrlr7m3;AuthMech=3;UseNativeQuery=1;UID=token;PWD=<personal_access_token>',
        'spark',
        true
    );

-- CDM daimon

INSERT INTO
    webapi.source_daimon(
        source_daimon_id,
        source_id,
        daimon_type,
        table_qualifier,
        priority
    )
VALUES (23, 7, 0, '<cdm_database_name>', 2);

-- VOCABULARY daimon

INSERT INTO
    webapi.source_daimon(
        source_daimon_id,
        source_id,
        daimon_type,
        table_qualifier,
        priority
    )
VALUES (24, 7, 1, '<vocab_database_name>', 2);

-- RESULTS daimon

INSERT INTO
    webapi.source_daimon(
        source_daimon_id,
        source_id,
        daimon_type,
        table_qualifier,
        priority
    )
VALUES (25, 7, 2, '<result_database_name>', 2);

-- EVIDENCE daimon

INSERT INTO
    webapi.source_daimon(
        source_daimon_id,
        source_id,
        daimon_type,
        table_qualifier,
        priority
    )
VALUES (26, 7, 3, '<evidence_database_name>', 2);