git:=https://github.com/express-magic/

.PHONY: \
clone \
zelda \
install \
update \
status \
rm

clone:
	git clone $(git)express-magic 
	git clone $(git)magic-blog
	git clone $(git)magic-cache
	git clone $(git)magic-errorHandler
	git clone $(git)magic-headers
	git clone $(git)magic-hosts
	git clone $(git)magic-log
	git clone $(git)magic-mail
	git clone $(git)magic-router
	git clone $(git)magic-skeleton
	git clone $(git)magic-utils
	git clone $(git)magic-view

zelda:
	cd ./express-magic && zelda ../
	cd ./express-magic && zelda ../
	cd ./express-magic && zelda ../
	cd ./magic-errorhandler && zelda ../
	cd ./magic-headers && zelda ../
	cd ./magic-hosts && zelda ../
	cd ./magic-log && zelda ../
	cd ./magic-mail && zelda ../
	cd ./magic-router && zelda ../
	cd ./magic-skeleton && zelda ../
	cd ./magic-utils && zelda ../
	cd ./magic-view && zelda ../

install: clone zelda

update:
	cd ./express-magic && git pull && zelda ../
	cd ./magic-blog && git pull && zelda ../
	cd ./magic-cache && git pull && zelda ../
	cd ./magic-errorHandler && git pull && zelda ../
	cd ./magic-headers && git pull && zelda ../
	cd ./magic-hosts && git pull && zelda ../
	cd ./magic-log && git pull && zelda ../
	cd ./magic-mail && git pull && zelda ../
	cd ./magic-router && git pull && zelda ../
	cd ./magic-skeleton && git pull && zelda ../
	cd ./magic-utils && git pull && zelda ../
	cd ./magic-view && git pull && zelda ../

status:
	cd ./express-magic && git status
	cd ./magic-blog && git status
	cd ./magic-cache && git status
	cd ./magic-errorHandler && git status
	cd ./magic-headers && git status
	cd ./magic-hosts && git status
	cd ./magic-log && git status
	cd ./magic-mail && git status
	cd ./magic-router && git status
	cd ./magic-skeleton && git status
	cd ./magic-utils && git status
	cd ./magic-view && git status

rm:
	rm ./express-magic -rf
	rm ./magic-blog -rf
	rm ./magic-cache -rf
	rm ./magic-errorHandler -rf
	rm ./magic-headers -rf
	rm ./magic-hosts -rf
	rm ./magic-log -rf
	rm ./magic-mail -rf
	rm ./magic-router -rf
	rm ./magic-skeleton -rf
	rm ./magic-utils -rf
	rm ./magic-view -rf
