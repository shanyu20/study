#!/bin/bash
# 功能：
# 1. 统计设备重启次数
# 2. 当网口没有连接网线时，则自动重启；用于测试设备频繁重启是否会进入异常
# 3. 注意：sh与bash的区别

this_dir=`pwd`
BFILE=$this_dir/bootcount
echo "BFILE is $BFILE"
if [ -e $BFILE ]; then
	VALUE=`cat $BFILE`
else
	VALUE=0
fi
VALUE=$((VALUE+1))
echo $VALUE > $BFILE
sync
echo "VALURE is $VALUE"
ETH_STATUS=`cat /sys/class/net/enp0s3/carrier`
echo "ETH_STATUS is $ETH_STATUS"
#if [ $ETH_STATUS -eq 0 ]; then			#在sh和bash中都支持	
#if [ "X$ETH_STATUS" = "X0" ]; then		#在/bin/sh用==会提示错误，在/bin/bash可以用==
#if ((ETH_STATUS == 0)); then			#在sh中不支持，提示“ETH_STATUS: not found”； 在bash中支持
if [ $ETH_STATUS = 0 ]; then
	sleep 5
	echo "00000"
	reboot
else
	echo "11111"
fi
