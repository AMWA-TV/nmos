# Networked Media Open Specifications

<a href="https://github.com/AMWA-TV/nmos/actions?query=workflow%3ALint"><img src="https://github.com/AMWA-TV/nmos/workflows/Lint/badge.svg"/></a> 
<a href="https://github.com/AMWA-TV/nmos/actions?query=workflow%3ARender"><img src="https://github.com/AMWA-TV/nmos/workflows/Render/badge.svg"/></a> 

<!-- INTRO-START -->

NMOS is a family name for specifications produced by the Advanced Media Workflow Association related to networked media for professional applications.

The table below lists the current specifications and provides links to their repositories on [github.com/AMWA-TV](https://github.com/AMWA-TV) and documentation on [specs.amwa.tv](https://specs.amwa.tv). The "Release" links will take you to the documentation and download page (↓) for the latest release of recent versions of the specification.

The [NMOS API Testing Tool](https://specs.amwa.tv/nmos-testing) supports the majority of these specifications.

The index of NMOS specs is now auto-generated (by the template code below) and appears <https://specs.amwa.tv/nmos>.

<table>
	<thead>
		<tr>
      <th style="text-align: center">Id</th>
      <th style="text-align: center">Name</th>
      <th style="text-align: center">Spec Status</th>
      <th style="text-align: center">Release(s)</th>
      <th style="text-align: center">Repository</th>
		</tr>
	</thead>
	<tbody>
		{% for spec in site.data.specs %}
		<tr>
			<td style="text-align: center"><a href="{{ spec.url }}">{{ spec.amwa_id }}</a></td>
			<td style="text-align: center"><a href="{{ spec.url }}">{{ spec.name }}</a></td>
			<td style="text-align: center">{{ spec.status }}</td>
			<td style="text-align: center">
				{% for release in spec.releases %}
					<div>
						<a href="{{ spec.url }}/{{ release }}">{{ release }}</a>
						<a href="{{ spec.repo_url }}/releases/tag/{{ release }}">↓</a>
					</div>
				{% endfor %}
			</td>
			<td style="text-align: center"><a href="{{ spec.repo_url }}">{{ spec.repo_name }}</a></td>
		</tr>
		{% endfor %}
	</tbody>
</table>

<!-- INTRO-END -->

This repository contains the source for general documention about NMOS.
