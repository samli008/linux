## custom Centos7 iso
```
yum -y install anaconda repodata createrepo mkisofs rsync

mount -o loop CentOS-7.2.iso /mnt/cdrom/

cp /mnt/cdrom/repodata/*-x86_64.xml  /ISO/repodata/comps.xml

cd /ISO

cp /mnt/cdrom/.discinfo /ISO

createrepo -g repodata/comps.xml ./
declare -x discinfo=`head -1 .discinfo`

createrepo -u "media://$discinfo" -g repodata/comps.xml .

genisoimage -v -cache-inodes -joliet-long -R -J -T -V CENTOS7 -o /xxx/c72.iso \
-c isolinux/boot.cat -bisolinux/isolinux.bin \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-eltorito-alt-boot -b images/efiboot.img -no-emul-boot .
```
