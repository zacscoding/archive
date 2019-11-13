# Go

- <a href="#ubuntu">Ubuntu golang 설정</a>  

---  

<div id="ubuntu"></div>

# Ubuntu golang 설정  

> golang 다운로드

```
$ cd /tmp
$ wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
$ tar -xf go1.13.4.linux-amd64.tar.gz
$ sudo mv ./go /usr/local/
```   

> 환경 변수 설정

```
$ vi ~/.profile

# golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

$ source ~/.profile
$ echo $GOROOT
/usr/local/go
$ echo $GOPATH
/home/app/go
```  
