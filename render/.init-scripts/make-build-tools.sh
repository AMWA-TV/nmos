#!/bin/bash

set -o errexit

git clone --single-branch --branch use-render-dir https://${GITHUB_TOKEN:+${GITHUB_TOKEN}@}github.com/AMWA-TV/nmos-doc-build-scripts .scripts
.scripts/install-dependencies.sh
