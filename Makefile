TESTS=$(shell find test -name "*.js")

all:
	make clean
	make deps
	make build
	make install

deps:
	# install global packages
	sudo npm install -g nodeunit
	sudo npm install -g node-gyp

	# install local packages
	sudo npm install nodeunit
	sudo npm install underscore

	# sync submodule
	git submodule update --init

build:
	# configure and build npm module
	node-gyp configure
	node-gyp build

install:
	# install npm module
	sudo node-gyp install

rebuild:
	# rebuild npm module
	node-gyp rebuild

clean:
	# remove module dependencies
	node-gyp clean
	sudo rm -rf build
	sudo rm -rf node_modules

test:
	nodeunit $(TESTS)

.PHONY: all deps build install rebuild clean test