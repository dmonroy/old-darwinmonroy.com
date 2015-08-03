# Both Python and Node programs will be put here.
BIN=$(shell dirname `which python`)
THEME=theme

# Development

frontend-dev: $(BIN)/bower $(BIN)/grunt $(BIN)/node-sass
	echo $(BIN)
	# To install all node packages
	cd $(THEME) && npm install && bower install

python-dev:
	# To install all python packages
	pip install -r requirements.txt

dev: python-dev frontend-dev

run:
	foreman start

run-hyde:
	hyde serve --port $(PORT)

run-grunt-watch:
	cd $(THEME) && grunt watch

grunt-build:
	cd $(THEME) && grunt build

deploy: grunt-build
	# TODO: write the deploy task

$(BIN)/npm:
	nodeenv -p --prebuilt

$(BIN)/bower: $(BIN)/npm
	npm install -g bower
	touch $(BIN)/bower

$(BIN)/coffee: $(BIN)/npm
	npm install -g coffee-script
	touch $(BIN)/coffee-script

$(BIN)/grunt: $(BIN)/npm
	npm install -g grunt-cli
	touch $(BIN)/grunt

$(BIN)/node-sass: $(BIN)/npm
	npm install -g node-sass
	touch $(BIN)/node-sass

$(BIN)/yo: $(BIN)/yo
	npm install -g yo
	npm install -g generator-webapp
	touch $(BIN)/yo
