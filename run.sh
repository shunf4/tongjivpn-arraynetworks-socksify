ip netns show | grep tjan
if [ "$?" != "0" ]; then
	ip netns add tjan
	ip link add veth-tjan1 type veth peer name veth-tjan2
	ip link set veth-tjan1 up
	ip tuntap add tap-tjan mode tap user root
	ip link set tap-tjan up
	ip link add br-tjan type bridge
	ip link set tap-tjan master br-tjan
	ip link set veth-tjan1 master br-tjan
	ip addr add 10.173.22.1/24 dev br-tjan
	ip link set br-tjan up
	iptables -t nat -A POSTROUTING -s 10.173.22.0/24 -d 0.0.0.0/0 -j MASQUERADE
	iptables -I FORWARD 1 -j ACCEPT
	ip link set veth-tjan2 netns tjan
	ip netns exec tjan ip addr add 10.173.22.2/24 dev veth-tjan2
	ip netns exec tjan ip link set veth-tjan2 up
	ip netns exec tjan ip link set dev lo up
	ip netns exec tjan ip link set veth-tjan2 up
	ip netns exec tjan ip route add default via 10.173.22.1
	export TJAN_SETUP=1
fi

ip netns exec tjan bash -c ./startMotionPro.sh
if [ "$?" = "0" ]; then
	echo Socks5 server will now run on 10.173.22.2:1080
	if [ "$1" = "-D" ]; then
		ip netns exec tjan sockd -D -f ./sockd-tjan.conf &
	else
		ip netns exec tjan sockd -f ./sockd-tjan.conf &
	fi
fi

