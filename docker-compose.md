# docker-compose  

> ## Simple Commands

```
$ docker-compose -f ./docker-compose.yaml up -d
$ docker logs -f [container_name]
$ docker-compose -f ./docker-compose.yaml down
```

> ## Index  

- [MariaDB](#MariaDB)
- [Postgres](#Postgres)  
- [MySQL](#MySQL)  
- [DynamoDB](#DynamoDB)  
- [Ubuntu](#Ubuntu)
- [Alpine Java](#Alpine-Java)
- [Swagger](#Swagger)
- [InfluxDB](#InfluxDB)
- [Grafana](#Grafana)  
- [Zookeeper](#Zookeeper)  
- [Kafka](#Kafka)  
- [RabbitMQ](#RabbitMQ)

---

# MariaDB

> docker-compose

```yaml
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

# Postgres

> docker-compose

```yaml
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

```cmd
zaccoding@zaccoding:~/compose/postgres$ docker exec -it postgres bash
root@f979f2462b94:/# psql -d postgres -U postgres
psql (11.2 (Debian 11.2-1.pgdg90+1))
Type "help" for help.

postgres=#
```

---  

# MySQL  

```yaml
version: '3.1'
services:
  db:
    image: mysql:8.0.17
    container_name: my-mysql
    command: ['--default-authentication-plugin=mysql_native_password', '--default-storage-engine=innodb']
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=my_database      
    ports:
      - 3306:3306
```  

--- 

# DynamoDB

```yaml
version: '3.1'
services:
  dynamodb:
    container_name: dynamodb
    image: amazon/dynamodb-local:latest
    ports:
      - "8000:8000"
    command: ["-jar", "DynamoDBLocal.jar", "-sharedDb", "-inMemory"]
```

---  

# Ubuntu

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

```CMD
$ docker build -t eg_sshd .
```

> docker-compose.yaml  


```yaml
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

```CMD
$ ssh root@localhost -p 49154
```

---  

# Alpine Java

```yaml
version: '2'

services:
  alpine-java:
    image: 'anapsix/alpine-java'
    container_name: alpine-java
    #command: 'echo before command && nslookup scan01 && echo after command'
    command: sh -c 'echo before comamnd; cd /tmp; java Temp scan01; echo after command'
    volumes:
     - ${PWD}/hosts:/etc/hosts:ro
     - ${PWD}/Temp.class:/tmp/Temp.class
```

---

# Swagger

```yaml
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

---  

# InfluxDB  

> docker-compose.yaml

```yaml
influxdb:
  image: influxdb:latest
  container_name: influxdb
  ports:
    - "8083:8083"
    - "8086:8086"
    - "8090:8090"
  env_file:
    - 'env.influxdb'
  volumes:
    # Data persistency
    - ./influxdb/data:/var/lib/influxdb
```  

> env.influxdb  

```
INFLUXDB_DATA_ENGINE=tsm1
INFLUXDB_REPORTING_DISABLED=false
INFLUXDB_DB=db0
INFLUXDB_ADMIN_USER=admins
INFLUXDB_ADMIN_PASSWORD=pass
```  

---  

# Grafana  

```yaml
version: '3'
services:
  grafana:
    container_name: grafana
    image: grafana/grafana:latest
    user: "1000"
    ports:
      - 3000:3000
    volumes:
      - ./gfdata:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_USER=admins
      - GF_SECURITY_ADMIN_PASSWORD=pass
```  

---  

# Zookeeper

> Standalone  

```yaml
version: '3.1'

services:
  zoo1:
    image: zookeeper
    restart: always
    hostname: zoo1
    ports:
      - 2181:2181
    environment:
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888;2181
    volumes:
      - ./temp-zookeeper1/data:/data
      - ./temp-zookeeper1/datalog:/datalog
```  

> Cluster  

```yaml
version: '2'

services:
  zookeeper:
    image: 'bitnami/zookeeper:latest'
    container_name: zookeeper1
    ports:
      - '2181'
      - '2888'
      - '3888'
    volumes:
      - zookeeper_data:/bitnami
    environment:
      - ZOO_SERVER_ID=1
      - ALLOW_ANONYMOUS_LOGIN=yes
      - ZOO_SERVERS=0.0.0.0:2888:3888,zookeeper2:2888:3888,zookeeper3:2888:3888
  zookeeper2:
    image: 'bitnami/zookeeper:latest'
    container_name: zookeeper2
    ports:
      - '2181'
      - '2888'
      - '3888'
    volumes:
      - zookeeper2_data:/bitnami
    environment:
      - ZOO_SERVER_ID=2
      - ALLOW_ANONYMOUS_LOGIN=yes
      - ZOO_SERVERS=zookeeper:2888:3888,0.0.0.0:2888:3888,zookeeper3:2888:3888
  zookeeper3:
    image: 'bitnami/zookeeper:latest'
    container_name: zookeeper3
    ports:
      - '2181'
      - '2888'
      - '3888'
    volumes:
      - zookeeper3_data:/bitnami
    environment:
      - ZOO_SERVER_ID=3
      - ALLOW_ANONYMOUS_LOGIN=yes
      - ZOO_SERVERS=zookeeper:2888:3888,zookeeper2:2888:3888,0.0.0.0:2888:3888

volumes:
  zookeeper_data:
    driver: local
  zookeeper2_data:
    driver: local
  zookeeper3_data:
    driver: local
```  

---  

# Kafka  

> Kafka with zokeeper

```yaml
version: '3.4'

services:
  zoo1:
    image: zookeeper:3.4.9
    container_name: zoo1
    hostname: zoo1
    ports:
      - "2181:2181"
    environment:
      - ZOO_MY_ID=1
      - ZOO_PORT=2181
      - ZOO_SERVERS=server1.1=zoo1:2888:3888
  kafka1:
    image: confluentinc/cp-kafka:5.2.1
    hostname: kafka1
    ports:
      - "9092:9092"
    container_name: kafka1
    environment:
      KAFKA_ADVERTISED_LISTENERS: LISTENER_DOCKER_INTERNAL://kafka1:19092,LISTENER_DOCKER_EXTERNAL://${DOCKER_HOST_IP:-127.0.0.1}:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: LISTENER_DOCKER_INTERNAL:PLAINTEXT,LISTENER_DOCKER_EXTERNAL:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: LISTENER_DOCKER_INTERNAL
      KAFKA_ZOOKEEPER_CONNECT: "zoo1:2181"
      KAFKA_BROKER_ID: 1
      KAFKA_LOG4J_LOGGERS: "kafka.controller=INFO,kafka.producer.async.DefaultEventHandler=INFO,state.change.logger=INFO"
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
    volumes:
      - ./zk-multiple-kafka-single/kafka1/data:/var/lib/kafka/data
    depends_on:
      - zoo1
```

---  

# RabbitMQ  

```yaml  
version: '3'

services:
  rabbitmq:
    image: "rabbitmq:3-management"
    hostname: "rabbit"
    ports:
      - "15672:15672"
      - "5672:5672"
    labels:
      NAME: "rabbitmq"
    volumes:
      - ./rabbitmq-isolated.conf:/etc/rabbitmq/rabbitmq.config
```
