# salt-workstation

Work in progress. It works for me and was tested on Xubuntu.

## Install Salt as a Masterless Minion

```shell
wget https://bootstrap.saltstack.com -O install_salt.sh
sudo sh install_salt.sh
sudo sed -i -e 's/#file_client: remote/file_client: local/' /etc/salt/minion
sudo systemctl disable salt-minion
```

## Configure salt

```shell
make config
```

## Sync States

```shell
make sync
```

## Pillar data

Example pillar data is in `pillar/data.sls.example`.

## Run

    make all
    
or

    make <formula-name>

## Notes

`sudo -E` will pass env variables and will make sure dbus session is shared. This is usefull for resetting the panel.

