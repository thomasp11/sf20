# SharkFest 2020 - Analyzing Honeypot Traffic

Here are some of the scripts I used to setup the Honeypot described in my
SharkFest 2020 presentation, Analyzing Honeypot Traffic.

The NAT_README.md file describes how to create an additional NAT interface on
CentOS 7 and how to forward traffic from all ports to the NAT interface. CentOS
7 uses firewalld and the included script will configure this as well. Finally
the nc-listen@.service system service can be used to run netcat and listen on a
specific port. In this example all ports from 1-65534 on the internet facing
interface are forwarded to port 65535 on the internal NAT interface. The nc
service should run on the NAT interface and listen on port 65535.

To capture traffic I used a [systemd tcpdump](https://github.com/thomasp11/systemd-packet-capture)
service to capture using a ring buffer. Captures can also be uploaded to
CloudShark using [this script](https://gist.github.com/thomasp11/fa7b6d1ef80bfbb0d4dcb28e9bce94af).
