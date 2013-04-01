#!/bin/bash

for i in `seq 108 108`; do
   MAC1=`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{10}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`
   MAC2=`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{10}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`

   lxc-create -t ubuntu -n 1vm${i}.lab.gogii.net;
   echo "
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
	address 192.168.254.${i}
	netmask 255.255.255.0
	network 192.168.254.0
	gateway 192.168.254.254

auto eth1
iface eth1 inet static
	address 172.30.0.${i}
	netmask 255.255.255.0

" > /var/lib/lxc/1vm${i}.lab.gogii.net/rootfs/etc/network/interfaces;
   echo "
nameserver 192.168.1.114
search lab.gogii.net
" > /var/lib/lxc/1vm${i}.lab.gogii.net/rootfs/etc/resolv.conf;
  rsync -av /root/.ssh/authorized_keys /var/lib/lxc/1vm${i}.lab.gogii.net/rootfs/root/.ssh/;
  echo "
lxc.network.type=veth
lxc.network.name=eth0
lxc.network.link=br0
lxc.network.flags=up
lxc.network.hwaddr = 00:${MAC1}
lxc.utsname = 1vm${i}.lab.gogii.net

lxc.network.type=veth
lxc.network.name=eth1
lxc.network.link=br1
lxc.network.flags=up
lxc.network.hwaddr = 00:${MAC2}

lxc.devttydir = lxc
lxc.tty = 4
lxc.pts = 1024
lxc.rootfs = /var/lib/lxc/1vm${i}.lab.gogii.net/rootfs
lxc.mount  = /var/lib/lxc/1vm${i}.lab.gogii.net/fstab
lxc.arch = amd64
lxc.cap.drop = sys_module mac_admin
lxc.pivotdir = lxc_putold

lxc.cgroup.devices.deny = a
lxc.cgroup.devices.allow = c *:* m
lxc.cgroup.devices.allow = b *:* m
lxc.cgroup.devices.allow = c 1:3 rwm
lxc.cgroup.devices.allow = c 1:5 rwm
lxc.cgroup.devices.allow = c 5:1 rwm
lxc.cgroup.devices.allow = c 5:0 rwm
lxc.cgroup.devices.allow = c 1:9 rwm
lxc.cgroup.devices.allow = c 1:8 rwm
lxc.cgroup.devices.allow = c 136:* rwm
lxc.cgroup.devices.allow = c 5:2 rwm
lxc.cgroup.devices.allow = c 254:0 rwm
lxc.cgroup.devices.allow = c 10:229 rwm
lxc.cgroup.devices.allow = c 10:200 rwm
lxc.cgroup.devices.allow = c 1:7 rwm
lxc.cgroup.devices.allow = c 10:228 rwm
lxc.cgroup.devices.allow = c 10:232 rwm
" > /var/lib/lxc/1vm${i}.lab.gogii.net/config;
  lxc-start -n 1vm${i}.lab.gogii.net -d;
  ssh -o 'StrictHostKeyChecking=no' 172.30.0.${i} "ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime";
done;
