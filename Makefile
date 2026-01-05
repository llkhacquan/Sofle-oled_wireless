.PHONY: build build-knob build-kiwikey clean

build: build-knob build-kiwikey

build-knob:
	cd knob && ./build.sh

build-kiwikey:
	cd kiwikey && ./build.sh

clean:
	rm -rf knob/build knob/zmk kiwikey/build kiwikey/zmk
