#!/bin/bash

# Load YAML values using yq
LISTEN_PORT=$(yq '.forward.listen_port' config.yaml)
DEST_IP=$(yq '.forward.dest_ip' config.yaml)
DEST_PORT=$(yq '.forward.dest_port' config.yaml)

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Flush old rules
iptables -t nat -F

# DNAT
iptables -t nat -A PREROUTING -p tcp --dport "$LISTEN_PORT" -j DNAT --to-destination "$DEST_IP:$DEST_PORT"

# SNAT
iptables -t nat -A POSTROUTING -p tcp -d "$DEST_IP" --dport "$DEST_PORT" -j MASQUERADE

# Forwarding rules
iptables -A FORWARD -p tcp -d "$DEST_IP" --dport "$DEST_PORT" -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p tcp -s "$DEST_IP" --sport "$DEST_PORT" -m state --state ESTABLISHED,RELATED -j ACCEPT
