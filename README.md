# Purpose

VueGraphqlAuthExample demonstrates how to use Rails, Vue, GraphQL and Devise together to create basic token authentication. The [related article](https://engineering.doximity.com/articles/token-authentication-with-rails-vue-graphql-and-devise) provides a step-by-step guide to help navigate the repo and set up auth on your application.

![](demo.gif)

# Setup

Please check `.ruby-version` and `.nvmrc` to ensure you have the right versions of Ruby and Node installed and activated on your system. Then run

```
bin/setup
```

# Docker setup

If you have docker and docker-compose installed:

```
$ docker-compose build
$ docker-compose up -d
$ docker-compose exec web bin/rails db:create db:migrate

```

The app should now be running at localhost:3000

# Usage

## Running the App

To run the app

```
foreman start
```

then head to http://localhost:3000/.

## Running Tests

All tests can be found in the `./spec`. Run the tests with

```
bin/rspec
```

# Contributing

Any and all feedback is welcome. Please feel free to open a pull request, issue or message me directly at me@jamesmklein.com.
