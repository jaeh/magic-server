#dockerimage name

p:='80:5000'
d:='jaeh/magic-server'
n:='magic'

build:
	docker build -t $(d) .

kill:
	docker kill $(n)
	docker rm $(n)

run:
	docker run -p $(p) --name=$(n) -d $(d) 

restart:
	docker kill $(n)
	docker rm $(n)
	docker run -p $(p) --name=$(n) -d $(d) 

all:
	build;
