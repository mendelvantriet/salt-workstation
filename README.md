# salt-workstation

Work in progress. It works for me and was tested on Xubuntu.

## Install Salt as a Masterless Minion

```shell
wget https://bootstrap.saltstack.com -O install_salt.sh
sudo sh install_salt.sh
sudo sed -i -e 's/#file_client: remote/file_client: local/' /etc/salt/minion
sudo systemctl disable salt-minion
```

## Install formulae

```shell
git clone <repo-url>
cd <repo-name>
sed -i -z 's|#file_roots:\n#  base:\n#    - /srv/salt|file_roots:\n  base:\n    - '$(pwd)'/salt|' /etc/salt/minion
sed -i -z 's|#pillar_roots:\n#  base:\n#    - /srv/pillar|pillar_roots:\n  base:\n    - '$(pwd)'/pillar|' /etc/salt/minion
```

## Sync States

```shell
sudo -E salt-call --local --state-output=mixed saltutil.sync_states
```

## Pillar data

Example pillar data is in `pillar/data.sls.example`.

## Run

    sudo -E salt-call --local --state-output=mixed state.apply
    
or

    sudo -E salt-call --local --state-output=mixed state.sls <formula-name>

`sudo -E` will pass env variables and will make sure dbus session is shared. This is usefull for resetting the panel.
