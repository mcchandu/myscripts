#!/bin/bash
#monitor available disk space
SPACE='df | sed -n '/ \ / $ / p' | gawk '{print $5}' | sed  's/%//'
if [ $SPACE -ge 60 ]
then
chandra.reddy@jktech.com
fi
