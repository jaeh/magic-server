git=https://github.com/jaeh/
clone:
	git clone $(git)jaeh.at.git ./jaeh.at
	git clone $(git)bwb.is.git ./bwb.is
	git clone $(git)oj.jaeh.at.git ./oliverjiszda.com
	git clone $(git)oj-staging.jaeh.at.git ./staging.oliverjiszda.com 

pull:
	cd ./jaeh.at/ && git pull
	cd ./bwb.is/ && git pull
	cd ./oliverjiszda.com/ && git pull
	cd ./staging.oliverjiszda.com/ && git pull

npm:
	cd ./jaeh.at && npm install
	cd ./bwb.is && npm install
	cd ./oliverjiszda.com && npm install
	cd ./staging.oliverjiszda.com && npm install

install: clone npm

update: pull npm

clean:
	rm ./jaeh.at -rf
	rm ./bwb.is -rf
	rm ./oliverjiszda.com -rf
	rm ./staging.oliverjiszda.com -rf

status:
	cd ./jaeh.at && git status
	cd ./staging.oliverjiszda.com && git status
	cd ./oliverjiszda.com && git status
	cd ./bwb.is && git status
