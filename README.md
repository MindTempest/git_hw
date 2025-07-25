
1. Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию:
   - фамилия и имя сотрудника из этого магазина;
   - город нахождения магазина;
   - количество пользователей, закреплённых в этом магазине.
# Ответ

``` sql
USE sakila;

SELECT 
    CONCAT(staff.first_name, ' ', staff.last_name) AS manager_name,
    city.city AS store_city,
    COUNT(customer.customer_id) AS customer_count
FROM 
    store
JOIN 
    staff ON store.manager_staff_id = staff.staff_id
JOIN 
    address ON store.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    customer ON store.store_id = customer.store_id
GROUP BY 
    store.store_id, manager_name, store_city
HAVING 
    COUNT(customer.customer_id) >300;
```

![Скриншот](https://github.com/MindTempest/git_hw/blob/main/task1.jpg)


2. Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.
# Ответ 
``` sql
USE sakila;

SELECT 
    COUNT(*) AS long_films_count
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film);
``` 
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/task2.jpg)


3. Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.
# Ответ
``` sql
USE sakila;

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_period,
    DATE_FORMAT(payment_date, '%M %Y') AS month_year,
    SUM(amount) AS total_payments,
    COUNT(*) AS rental_count
FROM 
    payment
WHERE 
    payment_date IS NOT NULL
GROUP BY 
    payment_period, month_year
ORDER BY 
    total_payments DESC
LIMIT 1;
```
![Скриншот](https://github.com/MindTempest/git_hw/blob/main/task3.jpg)
