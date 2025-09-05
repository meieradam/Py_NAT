'''
#!/bin/bash
# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Flush old rules (optional, to avoid duplicates on restart)
iptables -t nat -F

# DNAT: Forward ONLY TCP traffic destined to port 502 → 10.10.1.2:503
iptables -t nat -A PREROUTING -p tcp --dport 502 -j DNAT --to-destination 10.10.1.2:503

# SNAT/MASQUERADE: Only rewrite source for traffic forwarded from port 502
iptables -t nat -A POSTROUTING -p tcp -d 10.10.1.2 --dport 503 -j MASQUERADE


iptables -A FORWARD -p tcp -d 10.10.1.2 --dport 503 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p tcp -s 10.10.1.2 --sport 503 -m state --state ESTABLISHED,RELATED -j ACCEPT
'''

import os
import sys
import time

