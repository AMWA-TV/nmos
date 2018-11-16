#!/bin/bash

gh-md-toc --hide-header --depth=3 $1 | awk '/^  / {sub("  \\*","-"); print}'
