#docker external/internal port
xport:=80
iport:=5000
#docker image ID
tag:='magic/express-magic'
hosttag:='magic/magic-hosts'
basetag:='magic/base'
#docker name
name:='jaeh.at'
#node_env
env:='production'

.PHONY: base-build db-build build dev dev-force kill run restart re logs \
	db db-run db-restart db-re db-kill db-build \
	clearContainers clearImages \
	install update \
	magic-install magic-update \
	host-install host-update host-remove hosts \
	updateAll

base:
	docker build -t $(basetag) ./dockerbase/

base-build: base

build:
	docker build -t $(tag) ./server

hosts:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/${env}/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) --no-cache ./hosts

dev:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/development/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) ./hosts

dev-force:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/development/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) --no-cache ./hosts

kill:
	docker kill $(name)
	docker rm $(name)
	rm -f ./server/Dockerfile

run:
	docker run -p $(xport):$(iport) --name $(name) -d $(h)

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

update:
	git pull

all: build
