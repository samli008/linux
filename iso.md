## custom Centos7 iso
```
yum -y install anaconda repodata createrepo mkisofs rsync

mkdir /iso
mount c76.iso /mnt
cd /mnt
cp -r * /iso/

cd /iso
cp /mnt/.discinfo /iso
cp repodata/repomd.xml repodata/comps.xml

createrepo -g repodata/comps.xml ./
declare -x discinfo=`head -1 .discinfo`
createrepo -u "media://$discinfo" -g repodata/comps.xml .

genisoimage -v -cache-inodes -joliet-long -R -J -T -V CENTOS7 -o /root/c76ovirt.iso \
-c isolinux/boot.cat -bisolinux/isolinux.bin \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-eltorito-alt-boot -b images/efiboot.img -no-emul-boot .
```
