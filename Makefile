BUILD_DIR=build
PYTHON=`which python`
LEKTOR=`which lektor`

server:
	$(LEKTOR) server -h 0.0.0.0

gen:
	$(LEKTOR) build --output-path=${BUILD_DIR}

deploy: gen
	./deploy.sh

status:
	git status

add:
	git add .

commit: add
	git commit -m 'modify'

pull:
	git pull
	git update

push:
	git push -u origin master

commit-push: commit push
