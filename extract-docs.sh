#!/bin/bash


# Unlike the spec repos, the top-level nmos source-repo doesn't have a docs/ folder

function extract {
    checkout=$1
    target_dir=$2
    echo "Extracting documentation from $checkout into $target_dir"
    mkdir "$target_dir"
    cd source-repo
	git checkout "$checkout"
        cp -r *.md "../$target_dir/"
    cd ..

}


mkdir branches
for branch in $(cd source-repo; git branch -r | sed 's:origin/::' | grep -v HEAD | grep -v gh-pages); do
    extract "$branch" "branches/$branch"
done

mkdir tags
for tag in $(cd source-repo; git tag); do
    extract "tags/$tag" "tags/$tag"
done

