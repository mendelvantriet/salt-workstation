{
  "auths": {
    {% for registry in pillar['docker']['registries'] %}
    "{{ registry.name }}": {
      "auth": "{{ registry.auth }}"
    }
    {% endfor %}
  }
}
