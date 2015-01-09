git:=https://github.com/express-magic/

repositories:=\
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
magic-view \

.PHONY: \
clone \
zelda \
install \
update \
pull \
status \
rm


clone:
	for repo in $(repositories) ; do \
		git clone $(git)$$repo; \
	done

zelda:
	for repo in $(repositories) ; do \
		cd ./$$repo && zelda ../; \
	done

install: clone zelda

pull:
	for repo in $(repositories) ; do \
		cd ./$$repo && git pull; \
	done


status:
	for repo in $(repositories) ; do \
		cd ./$$repo && git status; \
	done

rm:
	for repo in $(repositories) ; do \
		rm ./$$repo -rf; \
	done

update: pull zelda

all: status
