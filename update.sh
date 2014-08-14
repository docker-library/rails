#!/bin/bash
set -e

current="$(curl -sSL 'https://rubygems.org/api/v1/gems/rails.json' | sed -r 's/^.*"version":"([^"]+)".*$/\1/')"

sed -ri 's/^(ENV RAILS_VERSION ).*/\1'"$current"'/' Dockerfile
sed -ri 's/^(FROM rails):.*/\1:'"$current"'/' *"/Dockerfile"
