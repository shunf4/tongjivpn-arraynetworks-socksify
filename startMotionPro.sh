(MotionPro -a | grep failed)
if [ "$?" = 0 ]; then
	echo Installing MotionPro
	pkill vpnd
	./MotionPro_install.sh
	ifconfig
	MotionPro -a
fi

if [ "$?" = 0 ]; then
	echo Starting MotionPro...
	MotionPro -s
	MotionPro -h vpn.tongji.cn -u$TJID -p$PASSWORD
	exit $?
else
	exit $?
fi
