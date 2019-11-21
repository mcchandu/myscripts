export dthold=60
df -h | awk '{print $5 " "$6}' | grep -v " Use Mounted" | while read output
do
#echo $output
used=0;
used=$(echo $output | awk '{print $1}' | cut -d'%' -f1 )
partition=$(echo $output | awk '{print $2}' )
if [[ $used -ge $dthold ]];then
echo "Running out of space \"$partition ($used%)\" on $(hostname) as on $(date)"
mail -s "Alert: Almost out of disk space $used%" chandra.reddy@jktech.com 
fi
done 
