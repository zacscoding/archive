## Shell script  

- <a href="#0001">마지막 실행 된 Command의 exit status 가져오기</a>  

---  

<div id="0001"></div>

> **마지막 실행 된 Command의 exit status 가져오기**  

```
#!/usr/bin/env bash
true
echo $?
false
echo $?
```  

```
0
1
```
