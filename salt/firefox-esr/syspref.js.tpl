// This file can be used to configure global preferences for Firefox
// Example: Homepage
//pref("browser.startup.homepage", "http://www.weebls-stuff.com/wab/");

pref("browser.tabs.warnOnClose", false);

{% for url in pillar['browser']['local_domains'] %}
pref("browser.fixup.domainwhitelist.{{ url }}", true);
{% endfor %}

