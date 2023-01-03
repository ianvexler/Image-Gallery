FROM ruby:3.1.3

RUN apt-get update -yqq

RUN apt-get install -yqq --no-install-recommends nodejs

COPY . /usr/src/app/

WORKDIR /usr/src/app

RUN bundle install
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD rails server -b 0.0.0.0