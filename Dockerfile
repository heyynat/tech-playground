FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
