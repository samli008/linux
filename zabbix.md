## install zabbix
```
wget https://mirrors.tuna.tsinghua.edu.cn/zabbix/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm
rpm -ivh zabbix-release-4.0-2.el7.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql
```
## install mysql
```
yum -y install mariadb-server
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'liyang';
```
## import zabbix database
```
rpm -ql zabbix-server-mysql | grep sql 
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pliyang zabbix
mysql -uroot  zabbix -e 'show tables'
```
## setup zabbix connect database
```
vi /etc/zabbix/zabbix_server.conf 
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=liyang
```
## modify timezone
```
vi /etc/httpd/conf.d/zabbix.conf
php_value date.timezone Asia/Shanghai
systemctl start httpd
systemctl enable httpd
```
