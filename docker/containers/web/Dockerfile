FROM ruby:2.4.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

COPY docker/containers/web/install-phantomjs.sh /
RUN /install-phantomjs.sh

RUN adduser --disabled-password --gecos '' dockeruser
USER dockeruser
RUN mkdir /home/dockeruser/project
WORKDIR /home/dockeruser/project

COPY Gemfile /home/dockeruser/project
COPY Gemfile.lock /home/dockeruser/project

COPY docker/containers/web/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
