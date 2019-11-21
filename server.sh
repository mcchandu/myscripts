#!/bin/bash

SYSINFO=`head -n 1 /etc/issue`
IFS=$'\n'
UPTIME=`uptime`
D_UP=${UPTIME:1}
MYGROUPS=`groups`
DATE=`date`
KERNEL=`uname -a`
VERSION=`cat /etc/redhat-release`
CPWD=`pwd`
ME=`whoami`
CPU=`arch`

printf "<=== SYSTEM ===>\n"
#echo "  Distro info:	"$SYSINFO""
dmidecode | grep -A3 '^System Information'
printf "  Kernel:\t"$KERNEL"\n"
echo "  VERSION: `cat /etc/redhat-release`"
printf "  Uptime:\t"$D_UP"\n"
free -m | awk '
/Mem/{print "  Memory:\tTotal: " $2 "Mb\tUsed: " $3 "Mb\tFree: " $4 "Mb"}
/Swap/{print "  Swap:\t\tTotal: " $2 "Mb\tUsed: " $3 "Mb\tFree: " $4 "Mb"}'
echo " NO of CPU: `lscpu | grep CPU`"
#printf "  Architecture:\t"$CPU"\n"
#cat /proc/cpuinfo | grep "model name\|processor" | awk '
#/processor/{printf "  Processor:\t" $3 " : " }
#/model\ name/{
#printf "  Date:\t\t"$DATE"\n"
printf "\n<=== Softwares ===>\n"

  java -version
printf "\n<=== USER ===>\n"
printf "  User:\t\t"$ME" (uid:"$UID")\n"
#Printf " number of Users:"" $who -u | wc -l"
echo "  No of users: `who -u|wc -l` "
printf "  Groups:\t"$MYGROUPS"\n"
printf "  Working dir:\t"$CPWD"\n"
printf "  Home dir:\t"$HOME"\n"
printf "\n<=== NETWORK ===>\n"
printf "  Hostname:\t"$HOSTNAME"\n"
ip -o addr | awk '/inet /{print "  IP (" $2 "):\t" $4}'
/sbin/route -n | awk '/^0.0.0.0/{ printf "  Gateway:\t"$2"\n" }'
cat /etc/resolv.conf | awk '/^nameserver/{ printf "  Name Server:\t" $2 "\n"}'
printf "\n<=== Kernel Parameters ===>\n"
  ulimit -aH
printf "\n<=== Disk Info ===>\n"
  df -h
echo "*********************************************************************"
echo "Below is the version list of Progress/Openedge servers have installed"
echo "*********************************************************************"
echo ""
for i in `locate *dlc/version*`
do
echo "$i"
cat $i
echo " "
done

echo ""
echo "*********************************************************************"
echo "Below is the version list of Tomcat servers have installed"
echo "*********************************************************************"
echo ""
for i in `locate *bin/version.sh*`
do
echo "$i"
$i | grep -i "Server version:"
echo " "
done
