FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y git
RUN npm i -g supervisor

ADD ./server /srv
RUN git clone https://github.com/jaeh/jaeh.at.git /srv/hosts/jaeh.at
RUN git clone https://github.com/jaeh/bwb.is.git /srv/hosts/bwb.is
RUN cd /srv; npm install
RUN cd /srv/hosts/jaeh.at; git pull; npm install
RUN cd /srv/hosts/bwb.is; git pull; npm install
EXPOSE  80
CMD cd /srv; NODE_ENV=production supervisor --harmony --extensions "node,js,jade,styl" app.js
