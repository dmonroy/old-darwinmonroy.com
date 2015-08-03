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
	rm -rfv content/media/theme
	ln -sv $(PWD)/theme/.tmp/media/theme content/media/theme
	rm -rvf theme/.tmp/bower_components
	ln -sv $(PWD)/theme/bower_components theme/.tmp/
	foreman start

run-hyde:
	hyde serve --port $(PORT)

run-grunt-watch:
	cd $(THEME) && grunt watch

grunt-build:
	cd $(THEME) && grunt build

build: grunt-build
	rm -rfv content/media/theme
	ln -sv $(PWD)/theme/dist/media/theme content/media/theme
	hyde gen

deploy: build
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
