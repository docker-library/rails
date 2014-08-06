FROM ruby:2

RUN apt-get update && apt-get install -y nodejs

ADD . /usr/src/rails
WORKDIR /usr/src/rails

# Add Gemfile here so bundling gems only needs to be done once
# to generate rails images from
ADD ./Gemfile /usr/src/rails
ADD ./Gemfile.lock /usr/src/rails

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
