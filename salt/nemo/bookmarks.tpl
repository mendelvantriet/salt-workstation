file:///home/mendel/Desktop Desktop
file:///home/mendel/Documents Documents
file:///home/mendel/Downloads Downloads

{% for bookmark in pillar.nemo.bookmarks -%}
{{ bookmark.path }} {{ bookmark.name }}
{% endfor %}

