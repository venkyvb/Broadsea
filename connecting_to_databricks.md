To enable Broadsea deployment to connect to CDM in Databricks lakehouse the following steps would need to be done -
* The fork https://github.com/venkyvb/WebAPI contains the changes to enable WebAPI to connect to CDM in Databricks. These include -
  - Adding spark-2.6.22.jar (this can be downloaded from the [Databricks website](https://www.databricks.com/spark/jdbc-drivers-archive)) to the /src/main/extras/spark folder. Note that upto the version 2.6.25 Databricks JDBC Driver is based on the Simba JDBC driver. Post 2.6.25 this has been changed to Databricks own JDBC driver. Using version > 2.6.25 would require changes in the WebAPI DataAccessConfig, which would need to be tested (which may require additional changes to the WebAPI itself). The testing outlined here has been done with v2.6.22 of the Databricks JDBC driver.
  - Adding the spark related dependencies to the maven profile `webapi-docker`.
  - Changes done to the Docker file to add this jar to the WebAPI.war when the `ohdsi/webapi` container image is created
  - Once these changes are done - build a docker image (e.g. `ghcr.io/venkyvb/webapi-spark`) and push the image to a container registry (e.g. Github Container registry)

* The changes in the current fork where the `docker-compose.yml` uses the new container image from above (e.g. `ghcr.io/venkyvb/webapi-spark`) instead of the `ohdsi/webapi` image.
