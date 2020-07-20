FROM ruby:2.6.3
LABEL maintainer="fred.schoeneman@gmail.com"

# Allow apt to work with https-based sources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

# Ensure we install an up-to-date version of Node
# See https://github.com/yarnpkg/yarn/issues/2888
# RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN curl -O https://nodejs.org/download/release/v12.4.0/node-v12.4.0-linux-x64.tar.gz

# Ensure latest packages for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

COPY Gemfile* /usr/src/app/
COPY .ruby-version /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler

ENV BUNDLE_PATH /gems

RUN bundle install

COPY . /usr/src/app/
COPY ./.roro/database.example.yml ./usr/src/app/config/

ENTRYPOINT [".roro/containers/web/docker-entrypoint.sh"]
