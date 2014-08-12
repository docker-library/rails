FROM ruby:2

RUN apt-get update && apt-get install -y nodejs

ENV RAILS_VERSION 4.1.4

RUN gem install rails --version "$RAILS_VERSION"
