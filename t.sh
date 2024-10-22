#!/bin/bash


docker run -v ./trivy_cache/:/root/.cache/  -v /var/run/docker.sock:/var/run/docker.sock aquasecurity/trivy:canary image --download-db-only
