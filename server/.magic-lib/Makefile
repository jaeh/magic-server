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

n=node_modules

.PHONY: \
install \
pull \
link link-deep link-global\
rm \
build

install:
	npm install

link-global:
	for repo in $(shell ls -d node_modules/*) ; do \
		(cd ./$$repo; sudo npm link); \
	done

link-deep:
	cd ./$(n)/magic-blog && \
	sudo npm link \
		magic-log;

	cd ./$(n)/magic-cache && \
	sudo npm link \
		magic-log \
		magic-utils;

	cd ./$(n)/magic-errorHandler && \
	sudo npm link \
		express \
		magic-log \
		magic-view;

	cd ./$(n)/magic-headers && \
	sudo npm link \
		magic-log;

	cd ./$(n)/magic-hosts && \
	sudo npm link \
		express \
		magic-log \
		magic-skeleton \
		vhost;

	cd ./$(n)/magic-router && \
	sudo npm link \
		magic-view;

	cd ./$(n)/magic-skeleton && \
	sudo npm link \
		magic-blog \
		magic-errorHandler \
		magic-headers \
		magic-log \
		magic-router \
		magic-utils;

	cd ./$(n)/magic-skeleton && \
	sudo npm link \
		magic-log;

	cd ./$(n)/express-magic && \
	sudo npm link \
		express \
		magic-hosts \
		magic-log;

rm:
	sudo rm ./node_modules -rf

link: link-global link-deep

build: install link
