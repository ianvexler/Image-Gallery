FROM ruby:3.1.2

RUN apt-get update -yqq

RUN apt-get install -yqq --no-install-recommends nodejs

COPY . /usr/src/app/

WORKDIR /usr/src/app

RUN bundle install

EXPOSE 3000
CMD rails server -b 0.0.0.0