# Задание 1. СУБД
## Кейс
## Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для каждой предметной области.

## Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему?

* Бюджетирование проектов с дальнейшим формированием финансовых аналитических отчётов и прогнозирования рисков. СУБД должна гарантировать целостность и чёткую структуру данных.
* Хеширование стало занимать длительно время, какое API можно использовать для ускорения работы?
* Под каждый девелоперский проект создаётся отдельный лендинг, и все данные по лидам стекаются в CRM к маркетологам и менеджерам по продажам. Какой тип СУБД лучше использовать для лендингов и для CRM? СУБД должны быть гибкими и быстрыми.
* Можно ли эту задачу закрыть одной СУБД? И если да, то какой именно СУБД и какой реализацией?
* Отдел контроля качества решил создать базу по корпоративным нормам и правилам, обучающему материалу и так далее, сформированную согласно структуре компании. СУБД должна иметь простую и понятную структуру.
* Можно ли под эту задачу использовать уже существующую СУБД из задач выше и если да, то как лучше это реализовать?
* Департамент логистики нуждается в решении задач по быстрому формированию маршрутов доставки материалов по объектам и распределению курьеров по маршрутам с доставкой документов. СУБД должна уметь быстро работать со связями.
* Можно ли к этой СУБД подключить отдел закупок или для них лучше сформировать свою СУБД в связке с СУБД логистов?
* Можно ли все перечисленные выше задачи решить, используя одну СУБД? Если да, то какую именно?

## Приведите ответ в свободной форме.

# Ответ
## PostgreSQL:

* Финансы → Таблицы + аналитические функции.
* CRM + лендинги → JSONB для гибкости.
* База знаний → Отдельная схема.
* Логистика → PostGIS для маршрутов.
* Кеширование → Redis как дополнение либо использовать индексы и материализованные представления в самой СУБД.

## В итоге
1. PostgreSQL – основная СУБД (финансы, CRM, логистика, база знаний).
2. Redis – кеширование и ускорение хеширования.

# Задание 2. Транзакции
##  Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы транзакция завершилась успешно. Ориентируйтесь на шесть действий.

## Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?
## Приведите ответ в свободной форме.

# Ответ
1. Проверка подписки
    - Система проверяет, активен ли автоплатёж для данного номера.
2. Проверка лимитов
    - Сверка с установленными пользователем условиями (макс. сумма, дата списания).
3. Авторизация и холдирование
    - Банк резервирует средства без дополнительного подтверждения (если настроено).
4. Запрос к оператору
    - Платежный шлюз отправляет запрос на пополнение.
5. Обработка ответа
    - При успехе — списание денег, при ошибке — повторная попытка или уведомление пользователя.
6. Фиксация и отчёт
    - Транзакция сохраняется в истории, пользователь получает уведомление (SMS/email).

### Автоплатёж

* Автоплатёж исключает ручное подтверждение, но требует дополнительных проверок (активность подписки, лимиты).
* При ошибках возможны повторные списания или автоматическая отмена подписки.

# Задание 3. SQL vs NoSQL

* Напишите пять преимуществ SQL-систем по отношению к NoSQL.
* Какие, на ваш взгляд, преимущества у NewSQL систем перед SQL и NoSQL.

## Приведите ответ в свободной форме.

# Ответ
## Пять преимуществ SQL перед NoSQL
1. Чёткая структура данных
    - целостность данных.
    - Идеально для финансовых операций. 
2. Cогласованность, долговечность критичны для банковских систем, CRM и т.д.
3. JOIN-запросы
    - Сложные аналитические выполняются эффективнее, чем в NoSQL.
    - Например, для отчётов с фильтрами по датам, регионам и продуктам.

4. SQL — универсальный язык, поддерживаемый реляционными СУБД (PostgreSQL Oracle и т.д ).
5. Встроенные механизмы безопасности
    - NoSQL часто требует дополнительных надстроек для аналогичного уровня защиты.

# Преимущества NewSQL перед SQL и NoSQL 
* Кластеры из узлов с поддержкой распределённых транзакций (в SQL это сложно, в NoSQL — редкость).
* Оптимизированы для высоконагруженных транзакций (микросервисы в банках).
* Миграция с PostgreSQL/MySQL проще.
* Поддержка аналитических запросов (как в SQL) и высокой скорости записи (как в NoSQL)

- Итог
- SQL — надёжность.
- NoSQL — гибкость и скорость.
- NewSQL — «золотая середина»

# Задание 4. Кластеры
* Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу выделено 1000 машин.
* На основе какого критерия будете выбирать тип СУБД и какая модель распределённых вычислений здесь справится лучше всего и почему?

## Приведите ответ в свободной форме.
# Ответ
* PostgreSQL — мощная реляционная СУБД, но "из коробки" она не предназначена для масштабирования на 1000 узлов
1. Ключевые критерии
    - Масштабируемость.
    - Поддержка распределённых вычислений
2. Тип нагрузки:
    - OLTP 
    - OLAP
4. Устойчивость к сбоям.
5. Экономическая эффективность – open-source.

На гуглил про колоночную Clickhouse, ни имел дела с такой, ну вроде как отвечает всем нужным критериям =) 
