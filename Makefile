.PHONY: build all source-repo docs indexes fix-links push clean

build: source-repo docs indexes fix-links

all: build push


source-repo:
	./get-source-repo.sh

docs:
	./extract-docs.sh

indexes:
	./make-indexes.sh

fix-links:
	./fix-links.sh

push:
	./push-to-github.sh

clean:
	./make-clean.sh
