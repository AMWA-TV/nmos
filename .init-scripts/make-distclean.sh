#!/bin/bash

set -o errexit

rm -rf source-repo branches tags index.md index-contents.md
rm -rf node_modules/ yarn.lock package-lock.json .scripts/ .layouts/ _layouts/ assets/ raml2html-nmos-theme/ _site/
