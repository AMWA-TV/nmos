# NMOS Specifications by Theme

The tables below are organised by theme. To see them organised by id, click [here](.)

{% for theme in site.data.themes %}

### {{ theme.name }}

{{ theme.description}}

{% include specs_by_theme_table.html filter_theme=theme.id show_releases=true %}

{% endfor %}
