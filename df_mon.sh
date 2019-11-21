# cat /bin/DiskMonitor.sh
#!/bin/ksh


# This script monitors available disk space.
# This script emails an alert when a locally mounted partition crosses a given threshold.
# Set your threshold percentage (do not include the % sign), email address, and excluded mount points, then add to crontab
#
# Add this to crontab -e for root
# Diskspace monitoring script
#0 6 * * * /bin/diskMonitor.sh >/dev/null 2>&1


THRESHOLD="65"
EMAIL='chandra.reddy@jktech.com'

# Excluded mount points *must* be pipe delimited
# "/proc|/export/home|Mounted" should always be included


EXCLUDE="/proc|Mounted"


df -h | awk '{print $7"\t"$4}' |egrep -v "(${EXCLUDE})" | while read LINE; do
 PERC=`echo $LINE |awk '{print $2}' |cut -d"%" -f1`
 if [[ $PERC -gt $THRESHOLD ]]; then
   echo "${PERC}% ALERT" | /usr/bin/mail -s "Disk Space Alert: ${LINE} used on `hostname`" $EMAIL
 fi
done
