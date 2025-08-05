# Docker

## dockerfile

共享挂载缓存：
RUN --mount=type=cache,target=/go/pkg/mod \
    cd /build/attacker-service && go mod download

## docker compose:
A docker-compose.yml + `docker compose up -d` can run a container 后台;
