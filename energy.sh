#!/bin/bash
export DISPLAY=:0
### BEGIN INIT INFO
# Provides:          watchDog
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: start watchDog
# Description:       start watchDog
### END INIT INFO

sec=2
cnt=0
PROC_NAME=main.py
pwd=/home/qianli/zyb/mechax_cv_trajectory/src/rune/rune

cd $pwd
allsource="source /opt/ros/humble/setup.bash"
start_energy="/usr/bin/python3 main.py"
$allsource
gnome-terminal -- bash -ic "source ~/.bashrc;cd $pwd;$start_energy;"
echo "Start energy finished"
sleep $sec

#Thread='ps -ef | grep $PROC_NAME | grep -v grep' //判断用到，具体用法自行百度

while [ 1 ]
do 
count=$(ps -ef | grep $PROC_NAME | grep -v grep | wc -l)
echo "Thread count: $count"
if [ $count -eq 0 ];then
	echo "Starting $PROC_NAME"
	cd ~
	echo "mechax2024" | sudo -S sudo chmod +777 /dev/ttyACM0
        cd $pwd
        gnome-terminal -- bash -ic "source ~/.bashrc;cd $pwd;$start_energy;"
	echo "$PROC_NAME has started!"
		sleep $sec
else
	echo "The $PROC_NAME is still alive!"
	sleep $sec

fi
done
