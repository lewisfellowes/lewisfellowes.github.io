#!/bin/bash
set -e

cd "$(dirname "$0")"

export JEKYLL_ENV=production

bundle install
bundle exec jekyll b

docker build -t lewisfellowes-site .
docker rm -f lewisfellowes-site 2>/dev/null || true
docker run -d \
  --name lewisfellowes-site \
  --restart unless-stopped \
  -p 4000:80 \
  lewisfellowes-site