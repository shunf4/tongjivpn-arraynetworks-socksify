MotionPro -a
MOTIONPRO_RESULT_1=$?
if [ "$MOTIONPRO_RESULT_1" = 0 ]; then
	(MotionPro -a | grep failed)
	MOTIONPRO_RESULT_2=$?
else
	MOTIONPRO_RESULT_2=0
fi

if [ "$MOTIONPRO_RESULT" = 0 ]; then
	echo Installing MotionPro
	pkill vpnd
	./MotionPro_install.sh
	ifconfig
	MotionPro -a
fi

if [ "$?" = 0 ]; then
	echo Starting MotionPro...
	MotionPro -s
	MotionPro -h vpn.tongji.cn -u$TJID -p$TJPASSWORD > /var/log/MotionPro.log 2>&1
	exit $?
else
	exit $?
fi
