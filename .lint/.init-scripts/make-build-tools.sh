#!/bin/bash

set -o errexit

git clone --single-branch --branch "${NMOS_LINT_SCRIPTS_BRANCH:-main}" https://${GITHUB_TOKEN:+${GITHUB_TOKEN}@}github.com/AMWA-TV/nmos-lint-scripts .scripts
.scripts/install-dependencies.sh
