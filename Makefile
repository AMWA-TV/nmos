.PHONY: build all source-repo docs readmes push clean



build: source-repo docs readmes

all: build push


source-repo:
	./get-source-repo.sh

docs:
	./extract-docs.sh

readmes:
	./make-readmes.sh

push:
	./push-to-github.sh

clean:
	./make-clean.sh
