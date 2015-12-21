#!/usr/bin/env bash

#Centos 7 is the latest release from the community. Centos7 is shipped with 3.10 Kernel. Many times people may need the latest Kernel. This article telling about how to upgrade from 3.10 to latest upstream kernel.

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml
#Once the installation is finished, make sure you have got new kernel.

awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg

#If the CentOS kernel version 3.19.x is listed first, then set grub to use 0 which will set the system to boot off the newer kernel. You might want to leave some of the older 3.10.x kernels on the system in case you decide to revert to the stock CentOS 7 kernel, but you can always modify the default kernel to use later on.

grub2-set-default 0

#Update the grub2 config so it's aware of the changes we just made.

grub2-mkconfig -o /boot/grub2/grub.cfg

# Next steps:
# - reboot
# - bash upgrade-centos-to-newest-kernel-after-reboot.sh