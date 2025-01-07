[default]
region = {{ pillar.aws.config.default_region }}
output = json

{% for profile in pillar.aws.config.profiles -%}

[profile {{ profile.name }}]
{% if profile.source_profile is defined and profile.source_profile -%}
  source_profile = {{ profile.source_profile }}
{% else -%}
  source_profile = default
{% endif -%}
{% if profile.role_arn is defined and profile.role_arn -%}
  role_arn = {{ profile.role_arn }}
{% endif -%}
{% if profile.mfa_serial is defined and profile.mfa_serial -%}
  mfa_serial = {{ profile.mfa_serial }}
{% endif %}
{% endfor %}

