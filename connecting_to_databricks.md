To enable Broadsea deployment to connect to CDM in Databricks lakehouse the following steps would need to be done -
* The fork https://github.com/venkyvb/WebAPI contains the changes to enable WebAPI to connect to CDM in Databricks. These include -
  - Adding spark-2.6.22.jar (this can be downloaded from the Databricks website) to the /src/main/extras/spark folder
  - Adding the spark related dependencies to the maven profile `webapi-docker`
  - Changes done to the Docker file to add this jar to the WebAPI.war when the `ohdsi/webapi` container image is created
  - Once these changes are done - build a docker image (e.g. `ghcr.io/venkyvb/webapi-spark`) and push the image to a container registry (e.g. Github Container registry)

* The changes in the current fork where the `docker-compose.yml` uses the new container image from above (e.g. `ghcr.io/venkyvb/webapi-spark`) instead of the `ohdsi/webapi` image.
