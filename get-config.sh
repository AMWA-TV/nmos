# This file is sourced from build scripts
# It now pulls in settings from _config.yml
# TODO: just read _config.yml once!

_CONFIG_YML=_config.yml

if [ ! -f $_CONFIG_YML ]; then
    echo Cannot find $_CONFIG_YML >&2 
    exit 1
else
    echo Getting config from $_CONFIG_YML
fi

REPO_ADDRESS=https://github.com/AMWA-TV$(awk '/baseurl:/ { print $2 }' $_CONFIG_YML)
DEFAULT_TREE=$(awk '/default_tree:/ { print $2 }' $_CONFIG_YML)
SHOW_TAGS=$(awk '/show_tags:/ { print $2 }' $_CONFIG_YML)
SHOW_BRANCHES=$(awk '/show_branches:/ { print $2 }' $_CONFIG_YML)