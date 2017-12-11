# Development Setup
Before getting started, you'll need to have Ruby 2.4.1 and Postgres 9.6
installed on your machine. If you need help with this, check out the setup guide
from [Go Rails](https://gorails.com/setup). Rather than following the last set
of steps to create a new app, you'll
[fork](https://help.github.com/articles/fork-a-repo/) this repo and then create
a local clone to work with. If you need help with things like forking, cloning,
and git in general, we recommend Udacity's [How to Use Git and
GitHub](https://www.udacity.com/course/how-to-use-git-and-github--ud775) course.

You will also need [PhantomJS](http://phantomjs.org/) installed. You can
download it from that webpage, or on a Mac simply run `brew install phantomjs`.

Once you have a copy of this project on your machine, you should run
`bin/setup`. At this point, it's a good idea to

1. run `bin/rspec` to make sure everything was installed properly
2. start the server and explore the app

Also you can run the app with a help of Docker...

## Bootstrapping using Docker
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
