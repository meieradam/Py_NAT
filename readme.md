# Setting up PyNAT

---

## Preperation

Before peforming any of the following steps make sure to have the service, sh, and yaml in the directory of your choice.  Preferably in /opt/PyNAT

---

###

#### Perform an update to make sure packages are in order

```bash
sudo apt update
```

#### Install yq

```bash
sudo apt install -y yq
```

---

#### Make the script executable

```bash
chmod +x /path/to/pynat.sh
```

---

#### Test it before integration

```bash
sudo /path/to/pynat.sh
```

#### Check if the iptables rules applied correctly

```bash
sudo iptables -t nat -L -n -v
```

---

#### Create the systemd service

```bash
sudo nano /etc/systemd/system/pynat.service
```

#### Enable the service and start it

```bash
sudo systemctl daemon-reload
sudo systemctl enable pynat.service
sudo systemctl start pynat.service
```

#### Check the status of the service

```bash
sudo systemctl status pynat.service
```

#### Reboot will make any changes made to the config.yaml

### If manual changes are needed without a reboot

```bash
sudo systemctl restart pynat.service
```

#### verify iptables rules applied

```bash
sudo iptables -t nat -L -n -v
```
