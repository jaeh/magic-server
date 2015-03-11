#docker external/internal port
xport:=80
iport:=5000
#docker image ID
magictag:=jascha/express-magic
hosttag:=jascha/magic-hosts
basetag:=jascha/magic-base
dbtag:=jascha/magic-db
#docker name
name:=jaeh.at
dbname:=magic-db
#node_env
env:=production

.PHONY: \
base basef \
build buildf \
hosts \
dev devf \
kill \
run drun drunf \
restart re \
devrestart devre dr de \
devrestartf devref drf \
logs \
rmContainers rmImages \
install \
update \
rebuild rebuildf \
cache \
all

clone:
	git clone https://github.com/express-magic/express-magic ./magic-lib/express-magic
	git clone https://github.com/express-magic/magic-blog ./magic-lib/magic-blog
	git clone https://github.com/express-magic/magic-cache ./magic-lib/magic-cache
	git clone https://github.com/express-magic/magic-errorHandler ./magic-lib/magic-errorHandler
	git clone https://github.com/express-magic/magic-headers ./magic-lib/magic-headers
	git clone https://github.com/express-magic/magic-hosts ./magic-lib/magic-hosts
	git clone https://github.com/express-magic/magic-log ./magic-lib/magic-log
	git clone https://github.com/express-magic/magic-mail ./magic-lib/magic-mail
	git clone https://github.com/express-magic/magic-router ./magic-lib/magic-router
	git clone https://github.com/express-magic/magic-skeleton ./magic-lib/magic-skeleton
	git clone https://github.com/express-magic/magic-utils ./magic-lib/magic-utils
	git clone https://github.com/express-magic/magic-view ./magic-lib/magic-view

#install modules from npm
node_modules:
	npm install \
		async \
		bash-color \
		express \
		jade \
		body-parser \
		compression \
		cookie-parser \
		morgan \
		nib \
		node-basicauth \
		serve-favicon \
		vhost \
		nodemailer \
		nodemailer-smtp-transport \
		bash-color \
		stylus

npm:
	cd ./magic-lib/magic-log; npm install
	cd ./magic-lib/magic-cache; npm install
	cd ./magic-lib/magic-blog; npm install
	cd ./magic-lib/magic-errorHandler; npm install
	cd ./magic-lib/magic-headers; npm install
	cd ./magic-lib/magic-mail; npm install
	cd ./magic-lib/magic-router; npm install
	cd ./magic-lib/magic-skeleton; npm install
	cd ./magic-lib/magic-utils; npm install
	cd ./magic-lib/magic-view; npm install
	cd ./magic-lib/magic-hosts; npm install
	cd ./magic-lib/express-magic; npm install

clean:
	rm ./magic-lib -rf
	rm ./node_modules -rf

prepare: clean clone node_modules npm

base:
	docker build -t $(basetag) .
basef:
	docker build -t $(basetag) --no-cache .

hosts:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/${env}/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) ./hosts
	rm ./hosts/Dockerfile  

dev:
#~ 	node --harmony ./magic-lib/magic-cache/cache.js
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/development/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) ./hosts
	rm ./hosts/Dockerfile  

devf:
	cp -f ./hosts/Dockerfile.tmpl ./hosts/Dockerfile
	sed -i 's/|env|/development/g' ./hosts/Dockerfile
	sed -i 's/|xport|/${xport}/g' ./hosts/Dockerfile
	docker build -t $(hosttag) --no-cache ./hosts
	rm ./hosts/Dockerfile  

kill:
	docker kill $(name)
	docker rm $(name)

run:
	docker run \
	-p $(xport):$(iport) \
	-v /srv/magic/magic-db:/magic-db \
	--name $(name) \
	-d $(hosttag)

logs:
	docker logs -f $(name)

restart: kill run
re: restart
devrestart: dev kill run logs
dr: devrestart


port:
	docker port $(name) $(iport)

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

rebuild: base dev restart
rebuildf: basef dev restart
all: rebuild

cache:
	node --harmony ./server/node_modules/magic-cache/cache.js
