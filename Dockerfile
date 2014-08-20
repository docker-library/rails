FROM ruby:2.1.2

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 4.1.5

RUN gem install rails --version "$RAILS_VERSION"
