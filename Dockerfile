FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /testapp
WORKDIR /testapp
ADD Gemfile /testapp/Gemfile
ADD Gemfile.lock /testapp/Gemfile.lock
RUN bundle install
ADD . /testapp