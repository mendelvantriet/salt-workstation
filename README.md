# salt-workstation

Work in progress. It works for me and was tested on Xubuntu.

## Install Salt

    sudo apt-get install curl
    
    # Download key
    sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
    # Create apt sources list file
    echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list

    sudo apt-get update
    sudo apt-get install salt-minion

## Pillar data

Example pillar data is in `pillar/data.sls.example`.

## Run

    sudo -E salt-call --local --state-output=mixed state.apply

`sudo -E` will pass env variables and will make sure dbus session is shared. This is usefull for resetting the panel.
