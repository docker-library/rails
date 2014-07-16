FROM rails:4.1.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000
CMD ["rails", "server"]

ONBUILD ADD . /usr/src/app
ONBUILD RUN bundle install --system
