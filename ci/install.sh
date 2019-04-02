#!/bin/bash

main() {
	swoole_ver="4.2.13"
	stage=$(mktemp -d)

	# Install swoole
	cd $stage
	wget -O swoole.tar.gz https://github.com/swoole/swoole-src/archive/v${swoole_ver}.tar.gz
	tar -zxf swoole.tar.gz
	cd swoole-src-${swoole_ver}
	phpize
	./configure --enable-sockets=yes --enable-openssl=yes --enable-mysqlnd=yes
	make -j4
	sudo make install
	phpenv config-add "$TRAVIS_BUILD_DIR/ci/swoole.ini"

	cd $TRAVIS_BUILD_DIR
	sudo rm -rf $stage
}

main