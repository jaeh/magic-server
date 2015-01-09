git:=express-magic/

repositories=\
express-magic \
magic-blog \
magic-cache \
magic-errorHandler \
magic-headers \
magic-hosts \
magic-log \
magic-mail \
magic-router \
magic-skeleton \
magic-utils \
magic-view 

.PHONY: \
install \
pull \
link \
rm \
build

install:
	npm install

pull:
	for repo in $(shell ls -d node_modules/*) ; do \
		(cd ./$$repo; git pull); \
	done

link:
	for repo in $(shell ls -d node_modules/*) ; do \
		(cd ./$$repo; sudo npm link); \
	done

rm:
	sudo rm ./node_modules -rf

build: install link
