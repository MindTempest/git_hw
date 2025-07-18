# Задание 1
#### 1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.
#### 1.2. Создайте учётную запись sys_temp.
#### 1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)
#### 1.4. Дайте все права для пользователя sys_temp.
#### 1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)
#### 1.6. Переподключитесь к базе данных от имени sys_temp.
#### Для смены типа аутентификации с sha2 используйте запрос:
#### ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
#### 1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.
#### 1.7. Восстановите дамп в базу данных.
#### 1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)
## Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.


# Ответ
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/fisr_sql.jpg)
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/permission_sql.jpg)
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/sakila_tables.jpg)

## Простыня
``` bash
docker run --name mysql8 -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql:8.0
docker exec -it mysql8 mysql -u sys_temp -p
wget https://downloads.mysql.com/docs/sakila-db.zip
unzip sakila-db.zip
docker cp sakila-db/sakila-schema.sql mysql8:/tmp/
docker cp sakila-db/sakila-data.sql mysql8:/tmp/
docker exec -i mysql8 mysql -u root -proot < sakila-db/sakila-schema.sql
docker exec -i mysql8 mysql -u root -proot < sakila-db/sakila-data.sql
docker exec -it mysql8 mysql -u root -proot -e "USE sakila; SHOW TABLES;"
```
## Узнаем ключи для задания 2
``` bash
docker exec mysql8 mysql -u sys_temp -ppassword -e "
SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'sakila' AND COLUMN_KEY = 'PRI'
ORDER BY TABLE_NAME;"
```

``` sql
CREATE USER 'sys_temp'@'%' IDENTIFIED BY 'password';
SELECT user, host FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'sys_temp'@'%';
```

# Задание 2. Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
# Ответ


| Таблица      |     Первичный ключ   |
|:------------:|:--------------------:|
| actor        |  actor_id            |
| address      |  address_id          |
| category     |  category_id         |
| city	       |  city_id             |
| country	     |  country_id          |
| customer     |  customer_id         |
| film  	     |  film_id             |
| film_actor   |  actor_id, film_id   |
| film_category|  film_id, category_id|
| film_text    |  film_id             |
| inventory	   |  inventory_id        |
| language     |  language_id         |
| payment      |  payment_id          |
| rental       |  rental_id           |
| staff        |  staff_id            |
| store        |  store_id            |

