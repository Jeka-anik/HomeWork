# Развернуть security group, ec2 и nginx, используя терраформ
using file _task1.tf_


# Подключиться к странице с nginx с локальной машины

```bash
anik@K53:~/HomeWork/hw42$ curl -I http://54.197.162.35/
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Fri, 12 Mar 2021 11:00:59 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Fri, 12 Mar 2021 10:57:09 GMT
Connection: keep-alive
ETag: "604b4905-264"
Accept-Ranges: bytes
```

# Создать s3 бакет, разместить в него веб-сайт, проверить доступность со своего компьютера, используя терраформ

Using _task3.tf_

# Для s3 бакета должно быть включено логгирование

сразу сделал в _task3.tf_