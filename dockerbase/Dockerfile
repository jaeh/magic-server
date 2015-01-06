FROM ubuntu:14.10

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

RUN npm i -g supervisor
RUN npm i -g browserify
