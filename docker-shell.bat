
set BASE_DIR=%cd%
set SECRETS_DIR=%cd%\..\secrets\
set GCS_BUCKET_NAME="mushroom-app-data-demo-mc"
set GCP_PROJECT="csci-e115-proj-survivor"
set GCP_ZONE="europe-west1"

REM Create the network if we don't have it yet
docker network inspect data-versioning-network >/dev/null 2>&1 || docker network create data-versioning-network

REM Build the image based on the Dockerfile
docker build -t data-version-cli -f Dockerfile .

REM Run Container
docker run --rm --name data-version-cli -ti ^
-v %BASE_DIR%:/app ^
-v %SECRETS_DIR%:/secrets ^
-e GOOGLE_APPLICATION_CREDENTIALS=/secrets/csci-e115-proj-survivor-031c7653322f.json ^
-e GCP_PROJECT=%GCP_PROJECT% ^
-e GCP_ZONE=%GCP_ZONE% ^
-e GCS_BUCKET_NAME=%GCS_BUCKET_NAME% ^
--network data-versioning-network data-version-cli