FROM ubuntu:14.10

RUN apt-get update
RUN apt-get install -y \
  software-properties-common \
  python-software-properties \
  python \
  g++ \
  make \
  git

RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y \
  nodejs

RUN npm i -g supervisor
RUN npm i -g browserify
