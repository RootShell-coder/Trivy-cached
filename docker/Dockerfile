FROM ghcr.io/aquasecurity/trivy:canary

RUN set -eux; \
  mkdir -p /root/.cache/db root/.cache/java-db root/.cache/fanal; \

RUN set -eux; \
   TRIVY_TEMP_DIR=$(mktemp -d); \
   trivy --cache-dir $TRIVY_TEMP_DIR image --download-db-only\; \
#   tar -cf ./db.tar.gz -C $TRIVY_TEMP_DIR/db ./cache/db/metadata.json ./cache/db/trivy.db; \
#   rm -rf $TRIVY_TEMP_DIR;
