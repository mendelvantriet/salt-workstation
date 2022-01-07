{
  "registry-mirrors": [
    {{ pillar['docker']['registry_mirrors'] | map('regex_replace', '(^.*)', '"\\1"') | join(', ') }}
  ]
}

