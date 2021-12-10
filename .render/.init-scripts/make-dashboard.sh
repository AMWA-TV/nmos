#!/usr/bin/env bash

SPECS_YML=_data/specs.yml
DASHBOARD=Dashboard.md

cat  << EOF > "$DASHBOARD"
## Dashboard

| ID + Docs | Repository | Default Branch | Lint (default) | Render (all) |
| --- | --- | --- | --- | --- |
EOF

# Using yaml2json and jq because yq is not packaged for APK.
# We could also get specs using curl https://specs.amwa.tv/nmos/specs,
# but the render might not yet be updated.

specs=$(yaml2json "$SPECS_YML")

for id in $(echo "$specs" | jq -r '.[].amwa_id'); do
    repo_address=$(echo "$specs" | jq -r '.[] | select(.amwa_id == "'"$id"'").repo_url')
    repo=$(echo "$specs" | jq -r '.[] | select(.amwa_id == "'"$id"'").repo_name')

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
| [${id^^}](https://specs.amwa.tv/${id,,}) \
| [$repo]($repo_address) \
| $default_branch \
| <a href="$repo_address/actions?query=workflow%3ALint"><img src="$repo_address/workflows/Lint/badge.svg"/></a> \
| <a href="$repo_address/actions?query=workflow%3ARender"><img src="$repo_address/workflows/Render/badge.svg"/></a> \
|
EOF
    )
    rm -rf "$repo"
done
