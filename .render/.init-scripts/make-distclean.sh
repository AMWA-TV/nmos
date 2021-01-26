#!/bin/bash

set -o errexit

rm -f index.md index-contents.md
rm -rf source-repo/ branches/ releases/
rm -rf .scripts/ .layouts/ _layouts/ assets/ raml2html-nmos-theme/ _site/ .ssh/
rm -rf node_modules/
rm -f yarn.lock package.json package-lock.json Gemfile.lock
