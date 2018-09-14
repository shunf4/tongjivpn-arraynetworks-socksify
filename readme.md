## Linux 远端服务器连接同济 VPN （ArrayNetworks SSL VPN）解决方案

**注意：本仓库是高度试验性的。请在运行任何程序前检查源代码是否会对系统造成损害。**

### Introduction

On August 29th 2018, Tongji University enabled its new VPN solution from ArrayNetworks AG Series SSL VPN. This repository provides a method to connect to VPN server and turns it into a SOCKS5 proxy.

### Mechanism

[An isolated network namespace](https://superuser.com/questions/983727/route-only-specific-traffic-through-vpn) + [Dante socks server](https://www.inet.no/dante/index.html)

### Dependency

- iproute2
- pkill
- [dante](https://www.inet.no/dante/index.html)

### Procedure

- Clone the repository

- Download the VPN client for your OS from [this Chinese download page of ArrayNetworks SSL VPN](http://client.arraynetworks.com.cn:8080/zh/troubleshooting), and place it as `MotionPro_install.sh` under the cloned repository folder

- View `startMotionPro.sh` and set the environment variable `TJID` and `PASSWORD` or simply replace them with the value.

- Run `run.sh` as *root*

- Now try connecting network through `socks://10.173.22.2:1080`

### Note
I am not good at bash scripts. Any issues or pull requests are warmly welcomed.

  

  