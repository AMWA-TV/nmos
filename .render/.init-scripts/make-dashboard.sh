#!/usr/bin/env bash

DASHBOARD=Dashboard.md
cat  << EOF > "$DASHBOARD"
## Dashboard

| ID + Docs | Repository | Default Branch | Lint (default) | Render (all) |
| --- | --- | --- | --- | --- |
EOF

for repo in \
    nmos \
    nmos-discovery-registration \
    nmos-device-connection-management \
    nmos-network-control \
    nmos-event-tally \
    nmos-audio-channel-mapping \
    nmos-system \
    nmos-authorization \
    nmos-grouping \
    nmos-api-security \
    nmos-secure-communication \
    nmos-authorization-practice \
    nmos-certificate-provisioning \
    nmos-receiver-capabilities \
    nmos-edid-connection-management \
    nmos-id-timing-model \
    nmos-parameter-registers \
    nmos-template \
    ; do
    repo_address="https://github.com/AMWA-TV/$repo"

    git clone --depth 1 "$repo_address" "$repo"
    cd "$repo"
        default_branch="$(git remote show origin | awk '/HEAD branch/ { print $3 }')"
        ID=$(awk '/amwa_id:/ { print $2; }' .render/_config.yml)
        cat << EOF >> "../$DASHBOARD"
| [$ID](https://amwa-tv.github.io/$repo) \
| [$repo]($repo_address) \
| $default_branch \
| <a href="$repo_address/actions?query=workflow%3ALint"><img src="$repo_address/workflows/Lint/badge.svg"/></a> \
| <a href="$repo_address/actions?query=workflow%3ARender"><img src="$repo_address/workflows/Render/badge.svg"/></a> \
|
EOF
    cd ..
    rm -rf "$repo"
done
