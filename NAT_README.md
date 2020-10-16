# NAT setup

* Create new namespace for netcat:
```
ip netns add netcat
ip netns exec netcat ifconfig lo up
```

* Create veth link.
```
ip link add v-eth1 type veth peer name v-peer1
```

* Add peer-1 to NS.
```
ip link set v-peer1 netns netcat
```

* Setup IP address of v-eth1.
```
ip addr add 192.168.1.1/24 dev v-eth1
ip link set v-eth1 up
```

* Setup IP address of v-peer1.
```
ip netns exec netcat ip addr add 192.168.1.2/24 dev v-peer1
ip netns exec netcat ip link set v-peer1 up
ip netns exec netcat ip link set lo up
```

* Setup default route

```
ip netns exec netcat ip route add default via 192.168.1.1
```

* Enable masq on huney

```
firewall-cmd --permanent --zone=huney --add-masquerade
```

* Enable NAT from v-eth

```
firewall-cmd --permanent --zone=huney --add-rich-rule='rule family=ipv4 source address=192.168.1.0/24 masquerade'
```

* Enable forwarding

```
sysctl net.ipv4.conf.v-eth1.forwarding=1
sysctl net.ipv4.conf.eth0.forwarding=1
```

* Test NAT works

```
ip netns exec netcat ping 8.8.8.8
```

* Delete old firewall rule

```
sudo firewall-cmd --zone=huney --remove-forward-port=port=1-65534:proto=tcp:toport=65535:toaddr=68.183.61.12
```

* Add new rule to NAT interface

```
sudo firewall-cmd --zone=huney --add-forward-port=port=1-65534:proto=tcp:toport=65535:toaddr=192.168.1.2 --permanent
```
