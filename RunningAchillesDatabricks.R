install.packages("devtools")
devtools::install_github("OHDSI/Achilles")
library(DatabaseConnector)
Sys.setenv(DATABASECONNECTOR_JAR_FOLDER="./opt/achilles/drivers")
downloadJdbcDrivers("spark")

library(Achilles)
connectionDetails <- createConnectionDetails(
  dbms="spark", 
  connectionString="jdbc:spark://adb-xxxxxxxxxxxxxxxx.10.azuredatabricks.net:443/default;transportMode=http;ssl=1;httpPath=sql/protocolv1/o/xxxxxxxxxxxxxxxx/<some_path>;AuthMech=3;UID=token;PWD=<personal_access_token>;UseNativeQuery=1;IgnoreTransactions=1"
)
achilles(connectionDetails, 
         cdmDatabaseSchema = " omopcdm_demo", 
         resultsDatabaseSchema = "omopcdm_demo_results",
         scratchDatabaseSchema = "omopcdm_demo_scratch",
         vocabDatabaseSchema = "omopcdm_demo",
         numThreads = 1,
         sourceName = "ADB_CDM_9",
         cdmVersion = "5.4",
         sqlOnly = TRUE)