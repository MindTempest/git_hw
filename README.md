# Задание 1
## На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

## Ответить в свободной форме.
# Ответ
## Master–Slave 
## Сильные стороны: разгрузка мастера по чтению, можно делать бэкапы со slave, меньше риск случайно сломать данные на копиях.
## Минусы: если мастер упадёт, запись остановится; переключение на новый мастер требует ручных действий.
## Master–Master
## Плюсы: можно писать в любую точку, повышенная отказоустойчивость — если один мастер упал, другой продолжает работать.
## Минусы: сложнее настройка, выше риск конфликтов (например, если две транзакции одновременно меняют одни и те же данные на разных мастерах), нужна логика их разрешения.



# Задание 2
## Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

## Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/master_repl_stat.jpg)
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/slave_repl.jpg)

## Делал с помощью docker-compose: 
``` yml
services:
  mysql-master:
    image: mysql:8.0
    container_name: mysql-master
    environment:
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - ./master-data:/var/lib/mysql
      - ./sakila-db:/docker-entrypoint-initdb.d
    ports:
      - "3312:3312"  
    command:
      - "--server-id=1"
      - "--log-bin=mysql-bin"
      - "--binlog-format=ROW"
      - "--binlog-do-db=sakila"
      - "--port=3312"  
    networks:
      - mysql-repl-net

  mysql-slave:
    image: mysql:8.0
    container_name: mysql-slave
    depends_on:
      - mysql-master
    environment:
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - ./slave-data:/var/lib/mysql
      - ./sakila_dump.sql:/docker-entrypoint-initdb.d/sakila.sql
    ports:
      - "3311:3312"  
    command:
      - "--server-id=2"
      - "--log-bin=mysql-bin"
      - "--relay-log=mysql-relay-bin"
      - "--read-only=1"
      - "--port=3312" 
    networks:
      - mysql-repl-net

networks:
  mysql-repl-net:
    driver: bridge
```
