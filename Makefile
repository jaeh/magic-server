#docker external/internal port
xport:=80
iport:=5000
#docker image ID
tag:='jaeh/magic-server'
#docker name
name:='jaeh.at'
#node_env
env:='production'

.PHONY: base build dev dev-force kill run restart re logs \
	clearContainers clearImages \
	install update \
	magic-install magic-update \
	host-install host-update host-remove \
	updateAll

base:
	docker build -t magic/base ./dockerbase/

build:
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	sed -i 's/|xport|/${xport}/g' ./Dockerfile
	docker build -t $(tag) .

dev:
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/development/g' ./Dockerfile
	sed -i 's/|xport|/${xport}/g' ./Dockerfile
	docker build -t $(tag) .

dev-force:
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/development/g' ./Dockerfile
	sed -i 's/|xport|/${xport}/g' ./Dockerfile
	docker build -t $(tag) --no-cache .


kill:
	docker kill $(name)
	docker rm $(name)
	rm -f ./Dockerfile

run:
	docker run -p $(xport):$(iport) --name=$(name) -d $(tag) 

restart: kill run

re: kill run

logs:
	docker logs $(name)

clearContainers:
	docker rm $(shell docker ps -a -q)

clearImages:
	docker rmi $(shell docker images -q)

install:
	su -c 'apt-get update && \
	apt-get install docker.io && \
	source /etc/bash_completion.d/docker.io'

magic-install:
	cd ./server/ && npm install

magic-update:
	cd ./server/ && npm update --save

host-install:
	git clone https://github.com/jaeh/jaeh.at.git ./server/hosts/jaeh.at
	git clone https://github.com/jaeh/bwb.is.git ./server/hosts/bwb.is
	git clone https://github.com/jaeh/oj.jaeh.at.git ./server/hosts/oliverjiszda.com
	git clone https://github.com/jaeh/oj-staging.jaeh.at.git ./server/hosts/staging.oliverjiszda.com

host-update:
	cd ./server/hosts/jaeh.at/ && git pull
	cd ./server/hosts/bwb.is/ && git pull
	cd ./server/hosts/oliverjiszda.com/ && git pull
	cd ./server/hosts/staging.oliverjiszda.com/ && git pull

host-remove:
	rm ./server/hosts/jaeh.at -rf
	rm ./server/hosts/bwb.is -rf
	rm ./server/hosts/oliverjiszda.com -rf
	rm ./server/hosts/staging.oliverjiszda.com -rf

host-status:
	cd ./server/hosts/jaeh.at && git status
	cd ./server/hosts/staging.oliverjiszda.com && git status
	cd ./server/hosts/oliverjiszda.com && git status
	cd ./server/hosts/bwb.is && git status

updateAll: \
	update \
	magic-update \
	host-update

all:
	build;
