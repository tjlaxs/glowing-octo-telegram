run:
	@love .

test: tests.lua
	@lua tests.lua

commit := $(shell git rev-parse --short HEAD | cut -d ' ' -f1)

build:
	mkdir -p target/classic
	cp classic/*.lua classic/LICENSE target/classic
	mkdir -p target/potential-octo-rotary-phone
	cp potential-octo-rotary-phone/*.lua potential-octo-rotary-phone/LICENSE target/potential-octo-rotary-phone
	cp -r assets target
	cp *.lua target
	cd target && zip -9 -r glowing-octo-telegram-$(commit).love .

clean:
	rm -rf target
