FROM ruby:2.1.3

RUN apt-get update && apt-get install -y nodejs postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 4.1.6

RUN gem install rails --version "$RAILS_VERSION"
