# nfs-HA with drbd storage
echo "choise 1 to install pcs on all nodes."
echo "choise 2 to config pcs cluster only one node."
echo "choise 3 to config nfs-HA only one node."
read -p "pls input your choise [1]: " n

case $n in
1)
yum -y install pcs fence-agents-all lvm2-cluster 
systemctl enable pcsd
systemctl start pcsd
echo "liyang" | passwd --stdin hacluster
;;

2)
read -p "pls intput node1 hostname: " pcs1
read -p "pls intput node2 hostname: " pcs2
read -p "pls intput cluster name: " name
pcs cluster auth $pcs1 $pcs2 -u hacluster -p liyang
pcs cluster setup --name $name $pcs1 $pcs2
pcs cluster start --all
pcs cluster enable --all
pcs property set stonith-enabled=false
pcs status cluster
;;

3)
read -p "pls input mfs-master vip [192.168.6.115]: " vip
read -p "pls input drbd device [drbd0]: " drbd

pcs property set stonith-enabled=false

pcs resource create fs Filesystem device="/dev/$drbd" directory="/nfs" fstype="xfs" --group mfsgroup

pcs resource create vip IPaddr2 ip=$vip cidr_netmask=24 --group mfsgroup

pcs resource create nfs systemd:nfs-server --group mfsgroup
;;

*)
echo "pls input 1-3 choise."
exit;

esac
