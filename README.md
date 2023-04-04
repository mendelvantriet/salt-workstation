# salt-workstation

Work in progress. It works for me and was tested on Xubuntu.

## Install Salt

    sudo git clone <this repo> /srv
    chown -R $USER:$USER /srv
    cd /srv

    # Install Salt as a Masterless Minion
    wget https://bootstrap.saltstack.com -O install_salt.sh
    sudo sh install_salt.sh
    sudo sed -i -e 's/#file_client: remote/file_client: local/' /etc/salt/minion

## Sync States

```console
sudo -E salt-call --local --state-output=mixed saltutil.sync_states
```

## Pillar data

Example pillar data is in `pillar/data.sls.example`.

## Run

    sudo -E salt-call --local --state-output=mixed state.apply
    
or

    sudo -E salt-call --local --state-output=mixed state.sls <formula-name>

`sudo -E` will pass env variables and will make sure dbus session is shared. This is usefull for resetting the panel.
