FROM ruby:3.1.1-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        php \
        sqlite3 \
        libsqlite3-dev

WORKDIR /work

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install