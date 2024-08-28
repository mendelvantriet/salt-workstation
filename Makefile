.PHONY: config
config:
	sudo sed -i -z 's|#file_roots:\n#  base:\n#    - /srv/salt|file_roots:\n  base:\n    - '$(pwd)'/salt|' /etc/salt/minion
	sudo sed -i -z 's|#pillar_roots:\n#  base:\n#    - /srv/pillar|pillar_roots:\n  base:\n    - '$(pwd)'/pillar|' /etc/salt/minion

.PHONY: sync
sync:
	sudo -E salt-call --local --state-output=mixed saltutil.sync_states

.PHONY: all
all:
	sudo -E salt-call --local --state-output=mixed state.apply

%:
	sudo -E salt-call --local --state-output=mixed state.sls $*

