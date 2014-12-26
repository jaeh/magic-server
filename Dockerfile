FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y git
RUN npm i -g supervisor

ADD ./server /srv
RUN cd /srv; npm install
EXPOSE  5000
CMD cd /srv; supervisor --harmony --extensions "node,js,jade,styl" app.js
