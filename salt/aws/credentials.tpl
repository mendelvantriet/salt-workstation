{% for profile in pillar.aws.credentials.profiles -%}
{% if profile.name == "default" -%}
  [{{ profile.name }}]
{% else -%}
  [profile {{ profile.name }}]
{% endif -%}
aws_access_key_id = {{ profile.aws_access_key_id }}
aws_secret_access_key = {{ profile.aws_secret_access_key }}

{% endfor %}

