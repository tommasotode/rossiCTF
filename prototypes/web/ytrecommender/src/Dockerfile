FROM ruby:3.0-alpine

RUN apk add --no-cache build-base git
RUN gem install sinatra rackup puma jwt base64

WORKDIR /app
COPY src.rb .

ENV FLAG="rossiCTF{CHANGEME}"

EXPOSE 4567
CMD ["ruby", "src.rb"]