FROM ruby:3.0-alpine

RUN apk add --no-cache build-base git
RUN gem install sinatra rackup puma jwt base64

WORKDIR /app
COPY src.rb .

ENV FLAG="flagflagflag" \
    JWT_SECRET="sadsadsadsadsadsadsadnsadisadijsadijsadijsasadnsadoisadjsaoiaaaa" \
    SESSION_SECRET="sadsadsadsadsadsadsadnsadisadbbbbdijsadijsasadnsadoisadjsaoiaaaa" \
    PORT=4567

EXPOSE 4567
CMD ["ruby", "src.rb"]