# docker-compose  

```
$ docker-compose -f ./docker-compose.yaml up -d
$ docker logs -f [container_name]
```

> ## Index  

- <a href="#mariadb">Mariadb </a>
- <a href="#postgres">Postgres</a>
- <a href="#ubuntu">Ubuntu</a>
- <a href="#swagger">Swagger</a>

---

<div id="mariadb"></div>

## Mariadb  

> docker-compose

```
version: '3.4'
services:
  mariadb:
    image: mariadb:10.2
    container_name: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: pass
      MYSQL_DATABASE: testdb
      MYSQL_USER: tester
      MYSQL_PASSWORD: tester
    ports:
      - "3306:3306"
    logging:
      driver: syslog
      options:
        tag: "{{.DaemonName}}(image={{.ImageName}};name={{.Name}};id={{.ID}})"
    networks:
      - backend
    restart: on-failure
    volumes:
     - ${PWD}/mariadb:/var/lib/mysql
     - ${PWD}/custom.cnf:/etc/mysql/conf.d/custom.cnf
networks:
  backend:
    driver: bridge
```

> custom.cnf

```
[mysqld]
character-set-server = utf8
collation-server = utf8_unicode_ci
skip-character-set-client-handshake
```  

> Mariadb cli

```
$ docker exec -it mariadb bash
root@19d6c77a0f0e:/# mysql -u tester -p testdb
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 9
Server version: 10.2.23-MariaDB-1:10.2.23+maria~bionic mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [testdb]>
MariaDB [testdb]>
MariaDB [testdb]> show tables
    -> ;
Empty set (0.01 sec)

MariaDB [testdb]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| testdb             |
+--------------------+
2 rows in set (0.00 sec)
```

---  

<div id="postgres"></div>

## Postgres

> docker-compose

```
version: '3.1'

services:
    postgres:
        image: postgres
        container_name: postgres
        restart: always
        environment:
            - POSTGRES_PASSWORD=pass
        ports:
            - "5432:5432"
```  

```
zaccoding@zaccoding:~/compose/postgres$ docker exec -it postgres bash
root@f979f2462b94:/# psql -d postgres -U postgres
psql (11.2 (Debian 11.2-1.pgdg90+1))
Type "help" for help.

postgres=#
```

---  

<div id="ubuntu"></div>

## Ubuntu  

> Dockerfile

```
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y sudo && apt-get install -y openssh-server
RUN apt-get install net-tools
RUN mkdir /var/run/sshd
RUN echo 'root:rootpw' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install docker
RUN apt-get install --assume-yes  apt-transport-https  ca-certificates  curl  gnupg-agent  software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt-get update && apt-get install --assume-yes docker-ce docker-ce-cli containerd.io

# Install docker-compose (TODO : dependencies)
# RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

> build the image

```
$ docker build -t eg_sshd .
```

> docker-compose.yaml  


```
version: '3.4'

services:
    ubuntu:
        image: eg_sshd
        container_name: ubuntu
        tty: true
        ports:
            - "49154:22"
```   

> ssh

```
$ ssh root@localhost -p 49154
```

---

<div id="swagger"></div>

## Swagger

```
version: '3.4'
services:
  swagger-ui:
    image: swaggerapi/swagger-ui
    container_name: swagger-ui
    environment:
        - SWAGGER_JSON=/config/swagger.json
        - BASE_URL=/swagger
    expose:
      - 8080    
    network_mode: "host"
    volumes:
        - ${PWD}/config:/config
```
