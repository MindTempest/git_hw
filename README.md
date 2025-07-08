# Задание 1. Elasticsearch
## Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный.

## Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name.

# Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/Elastic_get.jpg)

# Задание 2. Kibana
## Установите и запустите Kibana.

## Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty.

# Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/kibana_get.jpg)

# Задание 3. Logstash
## Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch.

## Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.

# Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/logstash.jpg)

# Задание 4. Filebeat.
## Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat.

## Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.

# Ответ

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/logs.jpg)

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/dashboard.jpg)

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/filebeat.jpg)

