# ubuntu

## Ubuntu default settings

- <a href="#root_password">Root password 설정 </a>  
- <a href="#ssh">SSH 설정 </a>  
- <a href="#hostname">Hostname 변경</a>
- <a href="#ip">고정 IP 설정</a>  
- <a href="#install_java">apt-get openjdk 설치 </a>
- <a href="#update_java">openjdk 버전 변경 </a>
- <a href="#sudo">sudo 설정</a>
- <a href="#bash_newline">sh \r\n -> \n </a>
- <a href="#basic_vim">기본 vim</a>

---  

<div id="root_password"></div>

## Root password 설정  

```
$ sudo passwd  
```

---  

<div id="ssh"></div>

## SSH 설정  

> ssh 체크

```
$ service ssh status
```  

> ssh 설치  

```
$ sudo apt-get install openssh-server
```  

> ssh 시작

```
$ service ssh restart
```  

> ssh 확인  

```
app@ubuntu:~$ dpkg --get-selections | grep ssh
openssh-client					install
openssh-server					install
openssh-sftp-server				install
ssh-import-id					install

app@ubuntu:~$ systemctl status ssh
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-01-21 16:29:15 PST; 2min 32s ago
 Main PID: 4265 (sshd)
   CGroup: /system.slice/ssh.service
           └─4265 /usr/sbin/sshd -D

Jan 21 16:29:15 ubuntu systemd[1]: Starting OpenBSD Secure Shell server...
Jan 21 16:29:15 ubuntu sshd[4265]: Server listening on 0.0.0.0 port 22.
Jan 21 16:29:15 ubuntu sshd[4265]: Server listening on :: port 22.
Jan 21 16:29:15 ubuntu systemd[1]: Started OpenBSD Secure Shell server.
Jan 21 16:30:37 ubuntu sshd[4378]: Accepted password for app from 192.168.5.1 port 10572 ssh2
Jan 21 16:30:37 ubuntu sshd[4378]: pam_unix(sshd:session): session opened for user app by (uid=0)

app@ubuntu:~$ ps -ef | grep sshd | grep -v grep
root       4265      1  0 16:29 ?        00:00:00 /usr/sbin/sshd -D
root       4378   4265  0 16:30 ?        00:00:00 sshd: app [priv]
app        4396   4378  0 16:30 ?        00:00:00 sshd: app@pts/0

```    

> root 초기 비밀번호 설정  

```
app@ubuntu:~$ sudo passwd
[sudo] password for app:
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
```  

> key 생성

```
# ssh-keygen -t rsa
```  

> key file check  

```
app@ubuntu:~/.ssh$ tree ./
./
├── id_rsa
└── id_rsa.pub
```  

> authorized_keys 파일 생성

```
$ tail id_rsa.pub >> authorized_keys
```  

> vi /etc/ssh/sshd_config  

```
# Authentication:
LoginGraceTime 120
#PermitRootLogin prohibit-password
PermitRootLogin without-password
StrictModes yes
```

---  

<div id="hostname"></div>

## Hostname 변경

> 확인  

```
$ hostname
```  

> 변경

```
$ hostnamectl set-hostname newhostname
```  

---  

<div id="ip"></div>  

## 고정 IP 설정  

#### Ubuntu 16

> vi /etc/network/interfaces  

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto ens33
#iface ens33 inet dhcp
iface ens33 inet static

address 192.168.5.78
netmask 255.255.255.0
broadcast 192.168.5.255
gateway 192.168.5.2
dns-nameservers 168.126.63.1 168.126.63.2
```  

> 네트워크 재시작(안되면 리붓)  

```
$ systemctl restart networking.service
```  

#### Ubuntu 18  
(https://www.lesstif.com/pages/viewpage.action?pageId=61899302)  

> 시스템 interface 확인  

```
root@app:~# ls /sys/class/net
ens33  lo
```  

> 설정 파일 수정  

```
root@app:~# vi /etc/netplan/50-cloud-init.yaml

network:
    ethernets:
        ens33:
            addresses: [192.168.79.130/24]
            dhcp4: no
            gateway4: 192.168.79.2
            nameservers:
                    addresses: [168.126.63.1,8.8.8.8]
    version: 2
```  

> 설정 적용  

```
# netplay apply
# ifconfig
# nslookup google.com
```

---  

<div id="install_java"></div>  

## apt-get openjdk 설치  

> apt-get 으로 openjdk-8 설치

```
root@app:~# apt-get install openjdk-8-jdk
root@app:~# apt-get install openjdk-8-jre
```  

> 확인  

```
root@app:~# java -version
openjdk version "1.8.0_191"
OpenJDK Runtime Environment (build 1.8.0_191-8u191-b12-2ubuntu0.18.10.1-b12)
OpenJDK 64-Bit Server VM (build 25.191-b12, mixed mode)

root@app:~# javac -version
javac 1.8.0_191
```  

---  

- <a href="#update_java">openjdk 버전 변경 </a>
<div id="update_java"></div>

## openjdk version 변경  

> java 버전 변경  

```
sudo update-alternatives --config java
대체 항목 java에 대해 (/usr/bin/java 제공) 3개 선택이 있습니다.

  선택       경로                                          우선순� 상태
------------------------------------------------------------
  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      자동 모드
* 1            /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java   1         수동 모드
  2            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      수동 모드
  3            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      수동 모드

Press <enter> to keep the current choice[*], or type selection number: 2
update-alternatives: using /usr/lib/jvm/java-11-openjdk-amd64/bin/java to provide /usr/bin/java (java) in manual mode

$ java -version
openjdk version "11.0.4" 2019-07-16
OpenJDK Runtime Environment (build 11.0.4+11-post-Ubuntu-1ubuntu218.04.3)
OpenJDK 64-Bit Server VM (build 11.0.4+11-post-Ubuntu-1ubuntu218.04.3, mixed mode, sharing)
```


> javac 버전 변경  

```
$ javac -version
javac 1.8.0_222

$ sudo update-alternatives --config javac
대체 항목 javac에 대해 (/usr/bin/javac 제공) 3개 선택이 있습니다.

  선택       경로                                           우선순� 상태
------------------------------------------------------------
  0            /usr/lib/jvm/java-11-openjdk-amd64/bin/javac      1111      자동 모드
* 1            /usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/javac   1         수동 모드
  2            /usr/lib/jvm/java-11-openjdk-amd64/bin/javac      1111      수동 모드
  3            /usr/lib/jvm/java-8-openjdk-amd64/bin/javac       1081      수동 모드

Press <enter> to keep the current choice[*], or type selection number: 0
$ javac -version
javac 11.0.4
```


---  



<div id="sudo"></div>

## sudo 설정  

> sudoer 편집  

```
root@app:~# vi /etc/sudoers  

# User privilege specification
root    ALL=(ALL:ALL) ALL
#app    ALL=(ALL:ALL) ALL
app     ALL=(ALL) NOPASSWD: ALL
```  

---  


<div id="bash_newline"></div>  

## sh \r\n -> \n

```
sed $'s/\r$//' ./install.sh > ./install.Unix.sh
```  

```
./install.Unix.sh --clang-completer
```  

---  

<div id="basic_vim"></div>  

## 기본 vim  

```
zaccoding@zaccoding:~$ export VISUAL=vim
zaccoding@zaccoding:~$ export EDITOR="$VISUAL"
```  

---  
