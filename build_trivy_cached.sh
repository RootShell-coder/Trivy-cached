#!/bin/bash

max_attempts=6
attempt=1
sleep_time=10

# >>> don't change >>>
mkdir -p docker/trivy_cache

tmp_max_attempts=$max_attempts
tmp_attempt=attempt

check_attempts() {
    local attempt=$1
    local max_attempts=$2

    if [ $attempt -gt $max_attempts ]; then
        echo "ERROR: maximum number of attempts ($max_attempts)."
        exit 1
    fi
}

while [ $attempt -le $max_attempts ]; do
    output=$(docker pull --platform linux/amd64 ghcr.io/aquasecurity/trivy:latest 2>&1)
    if echo "$output" | grep -q "retry-after:"; then
        sleep $sleep_time
        ((attempt++))
        check_attempts $attempt $max_attempts
    else
      echo "Trivy image pulled successfully."
      break
    fi
done

tmp_max_attempts=$max_attempts
tmp_attempt=attempt

while [ $attempt -le $max_attempts ]; do
    output=$(docker run --rm -v ./docker/trivy_cache/:/root/.cache/ ghcr.io/aquasecurity/trivy:latest --cache-dir /root/.cache image --download-db-only 2>&1)
    if echo "$output" | grep -q "retry-after:"; then
        sleep $sleep_time
        ((attempt++))
        check_attempts $attempt $max_attempts
    else
        echo "db update successfully."
        sudo chmod 644 ./docker/trivy_cache/db/trivy.db ./docker/trivy_cache/db/metadata.json
        break
    fi
done

tmp_max_attempts=$max_attempts
tmp_attempt=attempt

while [ $attempt -le $max_attempts ]; do
    output=$(docker run --rm -v ./docker/trivy_cache/:/root/.cache/ ghcr.io/aquasecurity/trivy:latest --cache-dir /root/.cache image --download-java-db-only 2>&1)
    if echo "$output" | grep -q "retry-after:"; then
        sleep $sleep_time
        ((attempt++))
        check_attempts $attempt $max_attempts
    else
        echo "java db update successfully."
        sudo chmod 644 ./docker/trivy_cache/java-db/trivy-java.db ./docker/trivy_cache/java-db/metadata.json
        break
    fi
done

check_attempts $attempt $max_attempts

if [ ! -s ./docker/trivy_cache/db/trivy.db ]; then
  echo "ERROR: The file ./docker/trivy_cache/db/trivy.db is empty."
  exit 1
fi

if [ ! -s ./docker/trivy_cache/db/trivy.db ]; then
  echo "ERROR: The file ./docker/trivy_cache/java-db/trivy-java.db is empty."
  exit 1
fi

sudo chown 1000:1000 -R docker/trivy_cache
# docker buildx build --no-cache -t ghcr.io/rootshell-coder/trivy-cached:latest docker
