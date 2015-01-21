#!/bin/bash
set -e

rubyBase='2.2'
rubyOnbuildDockerfile="https://raw.githubusercontent.com/docker-library/ruby/master/$rubyBase/onbuild/Dockerfile"

current="$(curl -sSL 'https://rubygems.org/api/v1/gems/rails.json' | sed -r 's/^.*"version":"([^"]+)".*$/\1/')"

set -x

curl -sSL "$rubyOnbuildDockerfile" -o onbuild/Dockerfile
echo >> onbuild/Dockerfile
grep '^RUN.*apt-get install' Dockerfile >> onbuild/Dockerfile
echo >> onbuild/Dockerfile
echo 'EXPOSE 3000' >> onbuild/Dockerfile
echo 'CMD ["rails", "server", "-b", "0.0.0.0"]' >> onbuild/Dockerfile

sed -ri '
	s/^FROM .*/'"$(grep '^FROM' onbuild/Dockerfile | head -1)"'/;
	s/^(ENV RAILS_VERSION) .*/\1 '"$current"'/
' Dockerfile
