# Домашнее задание к занятию "git_hw" - Lee

# Zbx_inst:
## Zabbix installation
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_inst.jpg)

# Ans_inst:
## Zabbix installation on host with ansible
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_ans.jpg)

# Hosts_ans:
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_data.jpg)

![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_web.jpg)

# Host_graphs  
## Graphs on host
![Screenshot](https://github.com/MindTempest/git_hw/blob/main/zabzab_data.jpg)


# Ansible role

## https://github.com/MindTempest/git_hw/blob/main/zbx_agent.tar.xz 

# Used commands
### sudo apt install -y zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
### sudo apt install -y apache2 php php-pgsql php-gd php-xml php-bcmath php-mbstring
### wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu$(lsb_release -rs)_all.deb
### sudo dpkg -i zabbix-release_*.deb
### sudo apt update
### sudo zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

### CREATE USER zabbix WITH PASSWORD 'пароль';
### CREATE DATABASE zabbix WITH OWNER zabbix ENCODING 'UTF8';
### GRANT ALL PRIVILEGES ON DATABASE zabbix TO zabbix;


#Zbx data
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_latest_data.jpg)

#Zbx logs
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_log.jpg)
![_new_Screenshot](https://github.com/MindTempest/git_hw/blob/main/zbx_log1.jpg)
