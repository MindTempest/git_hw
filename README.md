# Домашнее задание к занятию "git_hw" - Lee
# Задание 1
## Установите Zabbix Server с веб-интерфейсом.

* Процесс выполнения
* Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
  * Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
  * Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
  * Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

# Zbx_inst:
## Zabbix installation

# Used commands
```bash
  sudo apt install -y zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
  sudo apt install -y apache2 php php-pgsql php-gd php-xml php-bcmath php-mbstring
  wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu$(lsb_release -rs)_all.deb
  sudo dpkg -i zabbix-release_*.deb
  sudo apt update
  sudo zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

#### CREATE USER zabbix WITH PASSWORD 'пароль';
#### CREATE DATABASE zabbix WITH OWNER zabbix ENCODING 'UTF8';
#### GRANT ALL PRIVILEGES ON DATABASE zabbix TO zabbix;

![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_inst.jpg)
# Задание 2
## Установите Zabbix Agent на два хоста.

### Процесс выполнения
### Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
* Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
  * Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
  * Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
  * Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.
* Требования к результатам
  * Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
  * Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
  * Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
  * Приложите в файл README.md текст использованных команд в GitHub

  ```bash 
    sudo apt update
    sudo apt install zabbix-agent
    sudo nano /etc/zabbix/zabbix_agentd.conf
  ```
      Server=IP-адрес Zabbix Server
      ServerActive=IP для активных проверок
      Hostname=Имя хоста 
      ListenPort=Порт агента (по умолчанию 10050)
      LogFile=/var/log/zabbix/zabbix_agentd.log 
      EnableRemoteCommands=Разрешить удалённые команды (0 - запрещено)
 ```bash
    sudo systemctl restart zabbix-agent
    sudo systemctl enable zabbix-agent
    sudo systemctl status zabbix-agent
    sudo ufw allow 10050/tcp
    sudo ufw reload
 ```
# Hosts_ans:
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_data.jpg)

![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_web.jpg)

# Host_graphs  
## Graphs on host
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zabzab_data.jpg)





# Zbx data
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_latest_data.jpg)

# Zbx logs
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_log.jpg)
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_log1.jpg)
