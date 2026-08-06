#!/usr/bin/env python3
"""Generate the Zensical/MkDocs source tree for the NMOS spec index.

Inputs (checked into this repo):
  - spec_list.yml   : ordered list of spec slugs
  - themes.yml      : theme groupings (id, name, description, members)

For each spec listed in `spec_list.yml` we try to fetch its `spec.yml`
metadata (repo_name, title, etc.) from GitHub. If the fetch fails we fall
back to a stub entry so the build still succeeds -- individual spec repos
occasionally move or rename branches, and we don't want the whole index
to break because of one bad entry.

Outputs (written into `docs/`):
  - index.md      : landing page, links to both facets
  - by-theme.md   : specs grouped by theme, sorted within each group
  - by-type.md    : specs grouped by document type (IS / MS / BCP / INFO)
  - tags.md       : Material 'tags' plugin index page
  - specs/<slug>.md : one stub per spec, front-matter-tagged with its
                     type + theme(s) so search/tags act as filters
"""

from __future__ import annotations

import json
import os
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable

import yaml

try:
    import requests
except ImportError:  # pragma: no cover - workflow installs it
    requests = None  # type: ignore[assignment]


ROOT = Path(__file__).resolve().parent.parent
# Kept separate from the checked-in `docs/` (which contains hand-authored
# pages like FAQ.md, Introduction.md) so we never overwrite user content.
DOCS = ROOT / "build" / "docs"
SPECS_DIR = DOCS / "specs"

# Spec metadata is served rendered by specs.amwa.tv itself as `spec.json`,
# which is more reliable than reading each repo's raw `spec.yml` on GitHub:
# repos rename their default branches, and specs.amwa.tv already knows the
# correct name/status/releases for the currently-published version.
# The slug portion of the path is lower case.
SPEC_SOURCE = os.environ.get(
    "NMOS_SPEC_SOURCE",
    "https://specs.amwa.tv/{slug_lower}/spec.json",
)

# Ordering + display names for the document-type facet. Anything not matched
# here falls into "Other" so nothing silently disappears from the index.
TYPE_ORDER: list[tuple[str, str, str]] = [
    (
        "IS",
        "NMOS Interface Specifications (IS)",
        "APIs defined with RAML, JSON Schema and normative text.",
    ),
    (
        "MS",
        "NMOS Data Model Specifications (MS)",
        "Models for the resources used in NMOS APIs.",
    ),
    ("BCP", "NMOS Best Common Practices (BCP)", "Best practice for use of NMOS APIs."),
    (
        "INFO",
        "NMOS Informative Documents (INFO)",
        "Implementation guides and background information.",
    ),
    (
        "NMOS",
        "NMOS Registers & Feature Sets",
        "Parameter registers and control feature sets.",
    ),
]


@dataclass
class Spec:
    slug: str
    title: str = ""
    repo_name: str = ""
    status: str = ""
    url: str = ""
    releases: list[str] = field(default_factory=list)
    default_branch: str = ""
    show_in_index: bool = True
    themes: list[str] = field(default_factory=list)

    @property
    def type(self) -> str:
        # Slugs look like IS-04, BCP-003-01, NMOS-PARAMETER-REGISTERS, ...
        head = self.slug.split("-", 1)[0].upper()
        if head in {"IS", "MS", "BCP", "INFO"}:
            return head
        if head == "NMOS":
            return "NMOS"
        return "OTHER"

    @property
    def link(self) -> str:
        return f"specs/{self.slug}.md"


def load_yaml(path: Path):
    with path.open("r", encoding="utf-8") as fh:
        return yaml.safe_load(fh)


def fetch_spec_metadata(slug: str) -> dict:
    """Best-effort fetch of a spec's `spec.json` from specs.amwa.tv."""
    if requests is None:
        return {}
    url = SPEC_SOURCE.format(slug=slug, slug_lower=slug.lower())
    try:
        resp = requests.get(url, timeout=15)
        if resp.status_code != 200:
            print(
                f"  warn: {slug}: HTTP {resp.status_code} from {url}", file=sys.stderr
            )
            return {}
        try:
            data = resp.json()
        except json.JSONDecodeError:
            # Fall back to YAML in case someone points us at a raw spec.yml.
            data = yaml.safe_load(resp.text) or {}
        if not isinstance(data, dict):
            return {}
        return data
    except Exception as exc:  # noqa: BLE001 -- best effort
        print(f"  warn: {slug}: {exc}", file=sys.stderr)
        return {}


def build_specs(spec_slugs: Iterable[str], themes: list[dict]) -> dict[str, Spec]:
    # Reverse lookup: slug -> [theme id, ...] preserving themes.yml order.
    slug_to_themes: dict[str, list[str]] = {}
    for theme in themes:
        for member in theme.get("members", []) or []:
            slug_to_themes.setdefault(member, []).append(theme["id"])

    specs: dict[str, Spec] = {}
    for slug in spec_slugs:
        meta = fetch_spec_metadata(slug)
        # `name` is the human-friendly title on specs.amwa.tv; older repos
        # may still expose `title` in a raw spec.yml, so honour both.
        title = meta.get("name") or meta.get("title") or slug
        releases = meta.get("releases") or []
        if not isinstance(releases, list):
            releases = []
        specs[slug] = Spec(
            slug=slug,
            title=title,
            repo_name=meta.get("repo_name") or slug.lower(),
            status=meta.get("status") or "",
            url=meta.get("url") or f"https://specs.amwa.tv/{slug.lower()}/",
            releases=[str(r) for r in releases],
            default_branch=meta.get("default_branch") or "",
            show_in_index=bool(meta.get("show_in_index", True)),
            themes=slug_to_themes.get(slug, []),
        )
    return specs


# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------


def _sort_key(slug: str) -> tuple:
    """Natural-ish sort so IS-04 comes before IS-10 and BCP-002-01 before -02."""
    parts = re.split(r"[-_]", slug)
    return tuple((0, int(p)) if p.isdigit() else (1, p) for p in parts)


def render_spec_stub(spec: Spec, themes_by_id: dict[str, dict]) -> str:
    theme_names = [themes_by_id[t]["name"] for t in spec.themes if t in themes_by_id]
    # Tags let the Material `tags` plugin (and search) filter by type+theme.
    tags = [spec.type] + spec.themes
    front_matter = [
        "---",
        f"title: {spec.title}",
        "tags:",
        *[f"  - {t}" for t in tags],
        "---",
        "",
    ]
    releases_md = (
        ", ".join(f"[{r}]({spec.url.rstrip('/')}/branches/{r}/)" for r in spec.releases)
        if spec.releases
        else "_none published_"
    )
    body = [
        f"# {spec.slug} &mdash; {spec.title}",
        "",
        f"- **Document type:** {spec.type}",
        f"- **Status:** {spec.status or '_unknown_'}",
        f"- **Themes:** {', '.join(theme_names) if theme_names else '_none_'}",
        f"- **Canonical URL:** <{spec.url}>",
        f"- **Repository:** <https://github.com/AMWA-TV/{spec.repo_name}>",
        f"- **Default branch:** `{spec.default_branch or 'unknown'}`",
        f"- **Releases:** {releases_md}",
        "",
    ]
    return "\n".join(front_matter + body)


def render_index() -> str:
    return (
        "# Networked Media Open Specifications\n\n"
        "The tables on the following pages list the current NMOS "
        "specifications, best practices and informative documents. "
        "Use the search box or the tag index to filter by document "
        "type or theme.\n\n"
        "- [By theme](by-theme.md) &mdash; grouped by subject area\n"
        "- [By type](by-type.md) &mdash; grouped by document type\n"
        "- [Tags](tags.md) &mdash; filter by any type or theme\n"
    )


def render_by_theme(specs: dict[str, Spec], themes: list[dict]) -> str:
    lines = ["# Specifications by theme", ""]
    for theme in themes:
        members = sorted(
            (m for m in (theme.get("members") or []) if m in specs),
            key=_sort_key,
        )
        if not members:
            continue
        lines.append(f"## {theme['name']}")
        lines.append("")
        description = theme.get("description")
        if description:
            lines.append(description)
            lines.append("")
        lines.append("| Spec | Title | Type |")
        lines.append("| --- | --- | --- |")
        for slug in members:
            s = specs[slug]
            lines.append(f"| [{s.slug}]({s.link}) | {s.title} | {s.type} |")
        lines.append("")
    return "\n".join(lines)


def render_by_type(specs: dict[str, Spec]) -> str:
    buckets: dict[str, list[Spec]] = {}
    for spec in specs.values():
        buckets.setdefault(spec.type, []).append(spec)

    lines = ["# Specifications by type", ""]
    seen: set[str] = set()
    for key, heading, blurb in TYPE_ORDER:
        entries = sorted(buckets.get(key, []), key=lambda s: _sort_key(s.slug))
        if not entries:
            continue
        seen.add(key)
        lines.append(f"## {heading}")
        lines.append("")
        lines.append(blurb)
        lines.append("")
        lines.append("| Spec | Title | Themes |")
        lines.append("| --- | --- | --- |")
        for s in entries:
            theme_list = ", ".join(s.themes) if s.themes else "&mdash;"
            lines.append(f"| [{s.slug}]({s.link}) | {s.title} | {theme_list} |")
        lines.append("")

    # Anything unclassified.
    other = sorted(
        (s for k, group in buckets.items() if k not in seen for s in group),
        key=lambda s: _sort_key(s.slug),
    )
    if other:
        lines.append("## Other")
        lines.append("")
        lines.append("| Spec | Title | Themes |")
        lines.append("| --- | --- | --- |")
        for s in other:
            theme_list = ", ".join(s.themes) if s.themes else "&mdash;"
            lines.append(f"| [{s.slug}]({s.link}) | {s.title} | {theme_list} |")
        lines.append("")
    return "\n".join(lines)


def render_tags_page() -> str:
    # Populated automatically by the Material `tags` plugin.
    return "# Tags\n"


def main() -> int:
    spec_slugs = load_yaml(ROOT / "spec_list.yml") or []
    themes = load_yaml(ROOT / "themes.yml") or []
    themes_by_id = {t["id"]: t for t in themes}

    print(f"Loaded {len(spec_slugs)} specs across {len(themes)} themes.")

    specs = build_specs(spec_slugs, themes)

    DOCS.mkdir(parents=True, exist_ok=True)
    SPECS_DIR.mkdir(parents=True, exist_ok=True)

    (DOCS / "index.md").write_text(render_index(), encoding="utf-8")
    (DOCS / "by-theme.md").write_text(render_by_theme(specs, themes), encoding="utf-8")
    (DOCS / "by-type.md").write_text(render_by_type(specs), encoding="utf-8")
    (DOCS / "tags.md").write_text(render_tags_page(), encoding="utf-8")

    for spec in specs.values():
        (SPECS_DIR / f"{spec.slug}.md").write_text(
            render_spec_stub(spec, themes_by_id), encoding="utf-8"
        )

    print(f"Wrote {len(specs)} spec pages + 4 index pages to {DOCS}.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
