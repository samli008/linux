## enable kernel forward
```
cat >> /etc/sysctl.conf << EOF
net.ipv4.ip_forward = 1
EOF
sysctl -p | grep forward
```
## install pppoe
```
yum -y install rp-pppoe
pppoe-setup 
pppoe-start
pppoe-status
```
## firewalld service
```
systemctl enable firewalld
systemctl start firewalld
```
## view zone
```
firewall-cmd --get-zones
firewall-cmd --get-default-zone
```
## enable NAT
```
firewall-cmd --permanent --zone=public --add-masquerade
firewall-cmd --reload
firewall-cmd --query-masquerade
firewall-cmd --remove-masquerade
```
## accept port or service
```
firewall-cmd --permanent --zone=public --add-port=53/udp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=7789/tcp
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=high-availability
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload
firewall-cmd --list-all
```
## forward port
```
firewall-cmd --permanent --add-forward-port=port=3200:proto=tcp:toaddr=192.168.6.39:toport=81
firewall-cmd --reload
firewall-cmd --list-forward-port
```
## load ftp module on router
```
cat >> /etc/rc.local << EOF
modprobe ip_nat_ftp
EOF
chmod 755 /etc/rc.d/rc.local
source /etc/rc.local
```
## use script
```
cat > /usr/local/sbin/port << EOF
read -p "pls input wlan port: " wlan
read -p "pls input lan port: " lan
read -p "pls input lan ip: " ip
firewall-cmd --permanent --add-forward-port=port=$wlan:proto=tcp:toaddr=$ip:toport=$lan
firewall-cmd --reload
firewall-cmd --list-forward-port
EOF
chmod 755 /usr/local/sbin/port
```
## route add with config file
```
cat > /etc/sysconfig/network-scripts/route-eth0 << EOF
ADDRESS0=192.168.20.0
NETMASK0=255.255.255.0
GATEWAY0=192.168.20.1

ADDRESS1=192.168.30.0
NETMASK1=255.255.255.0
GATEWAY1=192.168.20.1
EOF

route add -net 192.168.6.0/24 gw 192.168.20.1
```
## route add on windows
```
route -p add 192.168.6.0 mask 255.255.255.0 192.168.20.1
```
