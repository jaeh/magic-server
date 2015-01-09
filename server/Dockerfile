FROM jascha/magic-base

ADD ./ /srv

RUN cd /srv/.magic-lib; npm install

RUN cd /srv/.magic-lib; make link

RUN cd /srv; npm install express jade
