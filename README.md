# Trivy cached DB

[![Trivy cached](https://github.com/RootShell-coder/Trivy-cached/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/RootShell-coder/Trivy-cached/actions/workflows/docker-publish.yml)[![Trivy cached](https://github.com/RootShell-coder/Trivy-cached/actions/workflows/docker-publish.yml/badge.svg?event=schedule)](https://github.com/RootShell-coder/Trivy-cached/actions/workflows/docker-publish.yml)

docker pull image

```bash
docker pull quay.io/keycloak/keycloak:latest
```

trivy scan image

```bash
docker run --rm ghcr.io/rootshell-coder/trivy-cached:latest image quay.io/keycloak/keycloak:latest
```
