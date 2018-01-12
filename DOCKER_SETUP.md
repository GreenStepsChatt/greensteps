# Bootstrapping using Docker
*These instructions assume that you have already forked and cloned the repo and
that you are in the project directory.*

1) Create `config/database.yml`(it stores the db configs) file:

  ```bash
  cp config/database.yml.example config/database.yml
  ```

2) Create `docker-compose.override.yml` file with docker preferences for development environment:

  ```bash
  cp docker-compose.development.yml docker-compose.override.yml
  ```

3) Create `.env` file to store all env. variables (uncomment the line with variable you wanna change):

  ```bash
  cp .env.example .env
  ```

4) Install [docker](https://docs.docker.com/engine/installation/) & [docker-compose](https://docs.docker.com/compose/install/) if you haven't got them yet and then run:

  ```bash
  docker-compose build
  ```

5) Create external volume for gems by running:

  ```bash
  docker volume create --name=greensteps_gems
  ```

6) Run the project:

  ```bash
  docker-compose up
  docker-compose up -d # Without logs
  ```

7) Create development & test PostgreSQL db's & run migrations inside docker's `web` container:

  ```bash
  docker-compose exec web rails db:create && docker-compose exec web rails db:migrate
  ```
