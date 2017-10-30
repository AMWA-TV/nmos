.PHONY: build all source-repo docs readmes fix-links push clean



build: source-repo docs readmes fix-links

all: build push


source-repo:
	./get-source-repo.sh

docs:
	./extract-docs.sh

readmes:
	./make-readmes.sh

fix-links:
	./fix-links.sh

push:
	./push-to-github.sh

clean:
	./make-clean.sh
