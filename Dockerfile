FROM ruby:2

ENV RAILS_VERSION 4.1.4

RUN gem install rails --version "$RAILS_VERSION"
