#!/bin/bash

set -o errexit

git clone https://${GITHUB_TOKEN:+${GITHUB_TOKEN}@}github.com/AMWA-TV/nmos-lint-scripts .scripts
.scripts/install-dependencies.sh
