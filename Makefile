#docker external/internal port
xport:=80
iport:=5000
#docker image ID
tag:='jaeh/magic-server'
#docker name
name:='jaeh.at'
#node_env
env:='production'

stagexport:=80
stageiport:=5000
stagename:='staging.jaeh.at'
stagetag:='jaeh/magic-server-staging'


build:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	sed -i 's/|xport|/${xport}/g' ./Dockerfile
	docker build -t $(tag) --no-cache .

all:
	build;

dev:
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

restart:
	docker kill $(name)
	docker rm $(name)
	docker run -p $(stagexport):$(stageiport) --name=$(name) -d $(tag) 

logs:
	docker logs $(name)

build-stage:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/staging/g' ./Dockerfile
	sed -i 's/|xport|/${stagexport}/g' ./Dockerfile
	docker build -t $(stagetag) --no-cache .

run-stage:
	docker run -p $(stageport) --name=$(stagename) -d $(stagetag)

restart-stage:
	docker kill $(stagename)
	docker rm $(stagename)
	docker run -p $(stagexport):$(stageiport) --name=$(stagename) -d $(stagetag)

make kill-stage:
	docker kill $(stagename)
	docker rm $(stagename)
	rm -f ./Dockerfile

logs-stage:
	docker logs $(stagename)

clearImageCache:
	docker rm $(shell docker ps -a -q)


host-install:
	git clone https://github.com/jaeh/jaeh.at.git ./server/hosts/jaeh.at
	git clone https://github.com/jaeh/bwb.is.git ./server/hosts/bwb.is
	git clone https://github.com/jaeh/oj.jaeh.at.git ./server/hosts/oj.jaeh.at

host-update:
	cd ./server/hosts/jaeh.at/ && git pull
	cd ./server/hosts/bwb.is/ && git pull
	cd ./server/hosts/oj.jaeh.at/ && git pull
	git pull

host-remove:
	rm ./server/hosts/* -rf
