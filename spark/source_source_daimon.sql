truncate ohdsi.source;
truncate ohdsi.source_daimon;

INSERT INTO webapi.source( source_id, source_name, source_key, source_connection, source_dialect, is_cache_enabled) 
VALUES (7, 'ADB_OMOP_7', 'ADB_OMOP_7', 
  'jdbc:spark://adb-631032391867030.10.azuredatabricks.net:443/default;transportMode=http;ssl=1;httpPath=sql/protocolv1/o/631032391867030/0309-002413-fvrlr7m3;AuthMech=3;UseNativeQuery=1;UID=token;PWD=dapic0f9f5e5505ebe6db4a3f91b73316979-3', 'spark', true); 
 
-- CDM daimon 
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (23, 7, 0, 'omopcdm_demo', 2); 
 
-- VOCABULARY daimon 
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (24, 7, 1, 'omopcdm_demo', 2); 
 
-- RESULTS daimon 
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (25, 7, 2, 'omopcdm_demo', 2); 
 
-- EVIDENCE daimon 
INSERT INTO webapi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (26, 7, 3, 'omopcdm_demo', 2); 
 
