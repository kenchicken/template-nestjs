---
to: <%= rootDirectory %>/api/docker-compose.yml
force: true
---
services:

  postgres:
    image: postgres:14.2-alpine
    container_name: <%= projectName %>-postgres
    ports:
      - "5432:5432"
    volumes:
      - ./docker/postgres/init.d:/docker-entrypoint-initdb.d
      - ./docker/postgres/pgdata:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_INITDB_ARGS: "--encoding=UTF-8"
      POSTGRES_DB: postgres
    hostname: postgres
    restart: always
    user: root
