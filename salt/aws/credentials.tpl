{% for profile in pillar['aws']['profiles'] %}
[{{ profile.name }}]
aws_access_key_id = {{ profile.aws_access_key_id }}
aws_secret_access_key = {{ profile.aws_secret_access_key }}

{% endfor %}

