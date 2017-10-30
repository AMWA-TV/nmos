#!/bin/bash

rm -rf source-repo/

git add -A
git commit -m "Build for GitHub Pages"
git fetch origin gh-pages
git push origin gh-pages
