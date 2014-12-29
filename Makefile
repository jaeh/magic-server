#docker external/internal port
port:='80:5000'
#docker image ID
tag:='jaeh/magic-server'
#docker name
name:='jaeh.at'
#node_env
env:='production'

stageport:='5000:5000'
stagename:='staging.jaeh.at'
stagetag:='jaeh/magic-server-staging'

build:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	docker build -t $(tag) --no-cache .

dev:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/development/g' ./Dockerfile
	docker build -t $(tag) --no-cache .

kill:
	docker kill $(name)
	docker rm $(name)
	rm -f ./Dockerfile

run:
	docker run -p $(port) --name=$(name) -d $(tag) 

restart:
	docker kill $(name)
	docker rm $(name)
	rm -f ./Dockerfile
	docker run -p $(port) --name=$(name) -d $(tag) 

logs:
	docker logs $(name)

build-stage:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/staging/g' ./Dockerfile
	docker build -t $(stagetag) --no-cache .

run-stage:
	docker run -p $(stageport) --name=$(stagename) -d $(stagetag)

restart-stage:
	docker kill $(stagename)
	docker rm $(stagename)
	rm -f ./Dockerfile
	docker run -p $(stageport) --name=$(stagename) -d $(stagetag)

make kill-stage:
	docker kill $(stagename)
	docker rm $(stagename)
	rm -f ./Dockerfile

logs-stage:
	docker logs $(stagename)

clearImageCache:
	docker rm $(docker ps -a -q)

all:
	build;
