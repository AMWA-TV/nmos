#!/bin/bash

# Change .md and .raml links to .html and rename APIs folder
perl -pi -e 's:\.(md|raml)\):.html\):g ; s:/APIs/:/html-APIs/:g' branches/*/docs/*.md



