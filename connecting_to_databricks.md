# Initial Set-up
To enable Broadsea deployment to connect to CDM in Databricks lakehouse the following steps would need to be done -
* The fork https://github.com/venkyvb/WebAPI contains the changes to enable WebAPI to connect to CDM in Databricks. These include -
  - Adding `spark-2.6.22.jar` (this can be downloaded from the [Databricks website](https://www.databricks.com/spark/jdbc-drivers-archive)) to the [/src/main/extras/spark](https://github.com/venkyvb/WebAPI/tree/master/src/main/extras/spark) folder.  Note that upto the version 2.6.25 Databricks JDBC Driver is based on the Simba JDBC driver. Post 2.6.25 this has been changed to Databricks own JDBC driver. Using version > 2.6.25 would require changes in the WebAPI DataAccessConfig, which would need to be tested (which may require additional changes to the WebAPI itself). The testing outlined here has been done with v2.6.22 of the Databricks JDBC driver.
  - Adding the spark related dependencies to the maven profile `webapi-docker`. (e.g. see [here](https://github.com/venkyvb/WebAPI/blob/4569019d8eb8e766ac5483df94e4dc034bcfe2ae/pom.xml#LL1336-L1382C15))
  - Changes done to the Docker file to add this jar to the WebAPI.war when the `ohdsi/webapi` container image is created
  - Once these changes are done - build a docker image (e.g. [ghcr.io/venkyvb/webapi-spark](https://github.com/venkyvb/WebAPI/pkgs/container/webapi-spark)) and push the image to a container registry (e.g. Github Container registry)

* The changes in the current fork where the `docker-compose.yml` uses the new container image from above (e.g. `ghcr.io/venkyvb/webapi-spark`) instead of the `ohdsi/webapi` image.

The testing has been done with Azure Databricks. Note that the parameter `UseNativeQuery=1` should be set as a part of the connection parameters.

# Running Achilles
There are few limitations that need to be considered when running Achilles against CDM in Databricks.
* Achilles scripts can be run from the RStudio. The relevant script is available [here](./RunningAchillesDatabricks.R). Please fill in the correct JDBC URL to the Databricks instance, input the values for the different schemas (CDM, Vocab, Results etc). Also make sure that these schemas are created in the Databricks catalog.
* Running the script will output an `achilles.sql` (typically the `output` folder) which would then need to be run against Databricks.
* Achilles also supports automatic creation of the tables, however due to limitations of the Spark JBDC driver running in this mode results in errors. Hence the approach of using the SQL script to deploy the relevant tables.
* In addtion to above, upload the data from the [achilles_analysis](achilles_analysis_details.csv) to the Databricks workspace and then copy the data and create it as a DELTA table in the `results` schema and name the table as `<result_schema_name>.achilles_analysis`.
