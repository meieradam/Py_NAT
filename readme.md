#### Perform an update to make sure packages are in order
sudo apt update

#### Install yq
sudo apt install -y yq

#### Make the script executable
chmod +x /path/to/pynat.sh

#### Test it before integration
sudo /path/to/pynat.sh

#### Check if the iptables rules applied correctly
sudo iptables -t nat -L -n -v

#### Create the systemd service
sudo nano /etc/systemd/system/pynat.service

#### Enable the service and start it
sudo systemctl daemon-reload
sudo systemctl enable pynat.service
sudo systemctl start pynat.service

#### Check the status of the service
sudo systemctl status pynat.service


#### Reboot will make any changes made to the config.yaml
### If manual changes are needed without a reboot
sudo systemctl restart pynat.service

#### verify iptables rules applied
sudo iptables -t nat -L -n -v
