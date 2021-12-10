#!/usr/bin/env bash

DASHBOARD=Dashboard.md
cat  << EOF > "$DASHBOARD"
## Dashboard

| ID + Docs | Repository | Default Branch | Lint (default) | Render (all) |
| --- | --- | --- | --- | --- |
EOF

for id in $(awk '/amwa_id/ {print $3}' _data/specs.yml); do 
    repo_address=$(curl -w "%{url_effective}\n" -I -L -s -S "https://specs.amwa.tv/${id,,}/repo" -o /dev/null)
    repo="${repo_address##*/}"

    git clone --depth 1 "$repo_address" "$repo"
    (
        cd "$repo" || exit 1
        default_branch="$(git remote show origin | awk '/HEAD branch/ { print $3 }')"
        config_id=$(awk '/amwa_id:/ { print $2; }' .render/_config.yml)
        if [[ "${config_id,,}" != "${id,,}" ]]; then
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
