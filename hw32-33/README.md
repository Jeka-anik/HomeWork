# Развернуть mysql и подкинуть нужную конфигурацию через ansible

Для разворачивания mysql, использовать плейбук *deb_mysql.yml*

# Посмотреть файл my.cnf, как его тюнить.

Посмотрел.
Пример конфигурации для машинки, с 2Гб оперативной памяти.
```
[client]
port                        = 3306
socket                      = /var/run/mysqld/mysqld.sock

[mysqld_safe]
socket                      = /var/run/mysqld/mysqld.sock
nice                        = 0

[mysqld]
user                        = mysql
pid-file                    = /var/run/mysqld/mysqld.pid
socket                      = /var/run/mysqld/mysqld.sock
port                        = 3306
basedir                     = /usr
datadir                     = /var/lib/mysql
tmpdir                      = /tmp
language                    = /usr/share/mysql/english
old_passwords               = 0
bind-address                = 127.0.0.1

skip-external-locking

max_allowed_packet          = 16M
key_buffer_size             = 16M
innodb_buffer_pool_size     = 1024M
innodb_file_per_table       = 1
innodb_flush_method         = O_DIRECT
innodb_flush_log_at_trx_commit  = 0

max_connections             = 136

		query_cache_size            = 0

slow_query_log              = /var/log/mysql/mysql-slow.log
long_query_time             = 1

expire_logs_days            = 10
max_binlog_size             = 100M

[mysqldump]
quick
quote-names
max_allowed_packet          = 16M
```

# Дополнить таблицу с корзиной в базе данных shop, с которой работали на уроке
```
mysql> select c.* from cart c;
+----+-------------+------------+
| id | customer_id | product_id |
+----+-------------+------------+
|  1 |           1 |          2 |
|  2 |           2 |          1 |
|  3 |           3 |          4 |
|  4 |           4 |          3 |
|  5 |           5 |          2 |
+----+-------------+------------+
5 rows in set (0.00 sec)
```

# Посчитать суммарную корзину покупок для каждого из пользователей и отсортировать по порядку
```
mysql> select p.*, c.customer_id from product p left join cart c on p.id=c.product_id;
+----+---------+-------------+-------+-------------+
| id | name    | description | price | customer_id |
+----+---------+-------------+-------+-------------+
|  1 | samsung | galaxy      |   500 |           2 |
|  2 | iphone  | x           |   650 |           5 |
|  2 | iphone  | x           |   650 |           1 |
|  3 | xiaomi  | mi          |   600 |           4 |
|  4 | xiaomi  | redmi       |   300 |           3 |
|  5 | huawei  | p40         |   400 |        NULL |
+----+---------+-------------+-------+-------------+
6 rows in set (0.00 sec)
```
```
mysql> select cs.name, c.product_id from customer cs left join cart c on cs.id=c.customer_id;
+-------+------------+
| name  | product_id |
+-------+------------+
| Ivan  |          2 |
| Vasya |          1 |
| Dima  |          4 |
| Oleg  |          3 |
| Kolya |          2 |
+-------+------------+
5 rows in set (0.00 sec)
```

```
mysql> select cs.name, p.price FROM customer cs JOIN cart c ON cs.id=c.customer_id JOIN product p ON p.id=c.product_id;
+-------+-------+
| name  | price |
+-------+-------+
| Ivan  |   650 |
| Vasya |   500 |
| Dima  |   300 |
| Oleg  |   600 |
| Kolya |   650 |
+-------+-------+
5 rows in set (0.00 sec)
```
сортировка:

```
mysql> select cs.name, p.price FROM customer cs JOIN cart c ON cs.id=c.customer_id JOIN product p ON p.id=c.product_id ORDER BY p.price;
+-------+-------+
| name  | price |
+-------+-------+
| Dima  |   300 |
| Vasya |   500 |
| Oleg  |   600 |
| Ivan  |   650 |
| Kolya |   650 |
+-------+-------+
5 rows in set (0.00 sec)
```
Группировка по расходам. Добавил покупателю Dima, еще один телефон
```
+-------+-------+
| name  | price |
+-------+-------+
| Dima  |   300 |
| Vasya |   500 |
| Oleg  |   600 |
| Dima  |   600 |
| Ivan  |   650 |
| Kolya |   650 |
+-------+-------+
6 rows in set (0.00 sec)
```
выполнил новый запрос:
```
mysql> select cs.name, SUM(p.price) FROM customer cs JOIN cart c ON cs.id=c.customer_id JOIN product p ON p.id=c.product_id GROUP BY cs.name;
+-------+--------------+
| name  | SUM(p.price) |
+-------+--------------+
| Ivan  |          650 |
| Vasya |          500 |
| Dima  |          900 |
| Oleg  |          600 |
| Kolya |          650 |
+-------+--------------+
5 rows in set (0.00 sec)
```

