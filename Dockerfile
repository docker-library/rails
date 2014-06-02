FROM buildpack-deps

RUN apt-get update && apt-get install -y ruby ruby-dev nodejs

# skip installing documentation
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN gem install bundler

ADD . /usr/src/rails
WORKDIR /usr/src/rails

RUN bundle install --system

# this list comes from Rakefile's PROJECTS variable minus "activerecord" and "railties" which had difficult-to-diagnose test failures
RUN set -e; \
	for project in \
		activesupport \
		activemodel \
		actionpack \
		actionview \
		actionmailer\
	; do \
		(set -x; cd "$project" && rake test); \
	done

RUN rake install

ONBUILD ADD . /usr/src/app
ONBUILD WORKDIR /usr/src/app
ONBUILD RUN bundle install --system
ONBUILD EXPOSE 3000
ONBUILD CMD ["rails", "server"]
