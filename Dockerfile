FROM ubuntu:latest

RUN apt-get install -y \
  software-properties-common

RUN add-apt-repository ppa:chris-lea/node.js -y
RUN apt-get update
RUN apt-get install -y \
  python-software-properties \
  python \
  g++ \
  make \
  git \
  nodejs

RUN npm install -g supervisor browserify linify babelify babel

RUN npm update -g npm

ADD ./magic-lib /magic-lib
ADD ./node_modules /node_modules

ADD ./server /srv

RUN cd /srv; rm node_modules/express-magic -r; npm i --unsafe-perm
