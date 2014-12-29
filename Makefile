#docker external/internal port
p:='80:5000'
#docker image ID
d:='jaeh/magic-server'
#docker name
n:='jaeh.at'
#node_env
env:='production'

build:
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	docker build -t $(d) .

kill:
	docker kill $(n)
	docker rm $(n)
	rm -f ./Dockerfile

run:
	docker run -p $(p) --name=$(n) -d $(d) 

restart:
	docker kill $(n)
	docker rm $(n)
	docker run -p $(p) --name=$(n) -d $(d) 

all:
	build;
