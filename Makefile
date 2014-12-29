#docker external/internal port
p:='80:5000'
#docker image ID
d:='jaeh/magic-server'
#docker name
n:='jaeh.at'
#node_env
env:='production'

build:
	docker build -t magic/base ./dockerbase/
	cp -f ./Dockerfile.tmpl ./Dockerfile
	sed -i 's/|env|/$(env)/g' ./Dockerfile
	docker build -t $(d) --no-cache .

kill:
	docker kill $(n)
	docker rm $(n)
	rm -f ./Dockerfile

run:
	docker run -p $(p) --name=$(n) -d $(d) 

logs:
	docker logs $(n)

restart:
	docker kill $(n)
	docker rm $(n)
	docker run -p $(p) --name=$(n) -d $(d) 

all:
	build;
