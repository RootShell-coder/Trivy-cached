FROM ghcr.io/aquasecurity/trivy:latest

RUN set -eux; \
  addgroup -S trivy; \
  adduser -S trivy -G trivy -h /home/trivy -s /bin/sh; \
  mkdir -p /home/trivy/.cache/fanal; \
  chown -R trivy:trivy /home/trivy;

COPY --chown=trivy:trivy ./trivy_cache/ /home/trivy/.cache/

RUN set -eux; \
  ls -lah /home/trivy/.cache/db/trivy.db; \
  ls -lah /home/trivy/.cache/java-db/trivy-java.db;

USER trivy
WORKDIR /home/trivy
ENTRYPOINT [ "/usr/local/bin/trivy", "--cache-dir", "/home/trivy/.cache" ]
