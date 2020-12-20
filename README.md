
### 1.0.3

Launch a MySQL server:

```
docker run -d --volume typo3-mysql:/var/lib/mysql/ --network typo3-db --env MYSQL_DATABASE=typo3 --env MYSQL_USER=db --env MYSQL_PASSWORD=db --env MYSQL_ROOT_PASSWORD=db --name typo3-mysql2 mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```

Use phpmyadmin for database administration:

```
$ docker pull phpmyadmin/phpmyadmin:latest
$ docker run --name phpmyadmin-container -d --network typo3-db --link typo3-mysql:db -p 8081:80 phpmyadmin/phpmyadmin
```

Build instance:

```
$ docker build -t chrisnt5/php-webdevops:1.0.3 .
$ docker run -d -p 80:80 -v $PWD/app:/var/www/html --network typo3-db --env TYPO3_DB_HOST=typo3-mysql --env TYPO3_DB_NAME=typo3 --env TYPO3_DB_USERNAME=db --env TYPO3_DB_PASSWORD=db --env TYPO3_ADMIN_USERNAME=christian --env TYPO3_ADMIN_PASSWORD=christian --env WEB_DOCUMENT_ROOT=/var/www/public --env WEB_DOCUMENT_INDEX=index.php --env-file .env --name typo3cms chrisnt5/php-webdevops:1.0.3
```

### 1.0.2
```
$ docker build -t chrisnt5/php-webdevops:1.0.0 .
$ docker run -d -p 80:80 -v $PWD/app:/var/www/html --network typo3-db --env TYPO3_DB_HOST=typo3-mysql --env TYPO3_DB_NAME=typo3 --env TYPO3_DB_USERNAME=db --env TYPO3_DB_PASSWORD=db --env TYPO3_ADMIN_USERNAME=christian --env TYPO3_ADMIN_PASSWORD=christian --env WEB_DOCUMENT_ROOT=/var/www/public --env WEB_DOCUMENT_INDEX=index.php --name typo3cms chrisnt5/php-webdevops:1.0.2
```

### Sample database

In case you need to import the default database, use this TYPO3 admin credentials:

Username: _typo34dmin
Password: _typo34dmin
