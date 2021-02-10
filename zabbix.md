## install zabbix
wget https://mirrors.tuna.tsinghua.edu.cn/zabbix/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm
rpm -ivh zabbix-release-4.0-2.el7.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql
yum -y install mariadb-server
