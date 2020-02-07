-include .scripts/scripts.mk

.PHONY: build-tools distclean

build-tools:
	./make-build-tools.sh

distclean:
	./make-distclean.sh
