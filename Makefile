#docker external/internal port
xport:=80
iport:=5000
#docker image ID
tag:='jaeh/magic-server'
#docker name
name:='jaeh.at'
#node_env
env:='production'

.PHONY: browserify build dev kill run restart re logs \
	clearContainers clearImages \

browserify:
	cd ./server/hosts/jaeh.at/public/ \
	&& browserify --ignore-missing ./js/bundle/index.js > ./js/main.js
	cd ./server/hosts/staging.oliverjiszda.com/public/ \
	&& browserify --ignore-missing ./js/bundle/index.js > ./js/main.js


build:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	sed -i 's/|xport|/${xport}/g' ./Dockerfile
	docker build -t $(tag) --no-cache .

dev: browserify
	docker build -t magic/base ./dockerbase/
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

re: restart

logs:
	docker logs $(name)

clearContainers:
	docker rm $(shell docker ps -a -q)

clearImages:
	docker rmi $(shell docker images -q)

install:
	npm install

update:
	git pull

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

updateAll: \
	update \ 
	magic-update \ 
	host-update

all:
	build;
