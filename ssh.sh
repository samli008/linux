# ssh trusted
yum -y install sshpass

sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config

ssh-keygen

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

sshpass -p liyang scp /root/.ssh/authorized_keys c04:/root/.ssh/
sshpass -p liyang scp /root/.ssh/authorized_keys c05:/root/.ssh/
sshpass -p liyang scp /root/.ssh/authorized_keys c06:/root/.ssh/
