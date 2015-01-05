#docker external/internal port
xport:=80
iport:=5000
#docker image ID
magictag:='magic/express-magic'
hosttag:='magic/magic-hosts'
basetag:='magic/base'
#docker name
name:='jaeh.at'
#node_env
env:='production'

.PHONY: \
	build dev dev-force \
	kill run restart re \
	logs \
	clearContainers clearImages \
	install update \
	magic-install

base:
	docker build -t $(basetag) ./dockerbase/
basef:
	docker build -t $(basetag) --no-cache ./dockerbase/

build:
	docker build -t $(magictag) ./server
buildf:
	docker build -t $(magictag) --no-cache ./server

hosts:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/${env}/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) ./hosts

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

run:
	docker run -p $(xport):$(iport) --name $(name) -d $(hosttag)

restart: kill run

re: kill run

logs:
	docker logs $(name)

rmContainers:
	docker rm $(shell docker ps -a -q)

rmImages:
	docker rmi $(shell docker images -q)

install:
	su -c 'apt-get update && \
	apt-get install docker.io && \
	source /etc/bash_completion.d/docker.io'

update:
	git pull

rebuild: base build dev restart
rebuildf: basef buildf dev restart
all: rebuild
