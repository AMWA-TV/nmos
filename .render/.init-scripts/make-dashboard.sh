#!/usr/bin/env bash

DASHBOARD=Dashboard.md
cat  << EOF > "$DASHBOARD"
## Dashboard

| ID + Docs | Repository | Default Branch | Lint (default) | Render (all) |
| --- | --- | --- | --- | --- |
EOF

for id in \
    nmos \
    is-04 \
    is-05 \
    is-06 \
    is-07 \
    is-08 \
    is-09 \
    is-10 \
    is-11 \
    ms-04 \
    bcp-002-01 \
    bcp-003-01 \
    bcp-003-02 \
    bcp-003-03 \
    bcp-004-01 \
    bcp-005-01 \
    info-002 \
    info-003 \
    nmos-parameter-registers \
    is-template \
    ; do
    repo_address=$(curl -w "%{url_effective}\n" -I -L -s -S "https://specs.amwa.tv/$id/repo" -o /dev/null)
    repo="${repo_address##*/}"

    git clone --depth 1 "$repo_address" "$repo"
    (
        cd "$repo" || exit 1
        default_branch="$(git remote show origin | awk '/HEAD branch/ { print $3 }')"
        config_id=$(awk '/amwa_id:/ { print $2; }' .render/_config.yml)
        if [[ "${config_id,,}" != "$id" ]]; then
            echo "amwa_id in _config.yml is $config_id - does not match expected $id"
            exit 1
        fi
        cat << EOF >> "../$DASHBOARD"
| [${id^^}](https://specs.amwa.tv/$id) \
| [$repo]($repo_address) \
| $default_branch \
| <a href="$repo_address/actions?query=workflow%3ALint"><img src="$repo_address/workflows/Lint/badge.svg"/></a> \
| <a href="$repo_address/actions?query=workflow%3ARender"><img src="$repo_address/workflows/Render/badge.svg"/></a> \
|
EOF
    )
    rm -rf "$repo"
done
