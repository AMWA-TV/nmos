-include .scripts/scripts.mk

.PHONY: lint-tools build-tools distclean

lint-tools:
	./.init-scripts/make-lint-tools.sh

build-tools:
	./.init-scripts/make-build-tools.sh

distclean:
	./.init-scripts/make-distclean.sh
