{
  "policies": {
    "Certificates": {
      "ImportEnterpriseRoots": true,
    },
    "Homepage": {
      "URL": "{{ pillar['browser']['homepage'] }}",
      "Locked": false,
      "Additional": [],
      "StartPage": "none"
    },
    "SearchEngines": {
      "Default": "{{ pillar['browser']['default_search_engine'] }}"
    }
  }
}
