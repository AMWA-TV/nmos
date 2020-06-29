-include .scripts/scripts.mk

.PHONY: build-tools distclean

build-tools:
	./.init-scripts/make-build-tools.sh

distclean:
	./.init-scripts/make-distclean.sh
