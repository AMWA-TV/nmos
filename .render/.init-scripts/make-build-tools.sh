#!/bin/bash

set -o errexit

git clone --single-branch --branch "${NMOS_DOC_BUILD_SCRIPTS_BRANCH:-main}" https://${GITHUB_TOKEN:+${GITHUB_TOKEN}@}github.com/AMWA-TV/nmos-render-scripts .scripts
.scripts/install-dependencies.sh
