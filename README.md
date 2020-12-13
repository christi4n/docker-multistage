
```
$ docker build -t chrisnt5/php-webdevops:1.0.0 .
$ docker run -d -p 80:80 -v $PWD/app:/var/www/html --network typo3-db --env TYPO3_DB_HOST=typo3-mysql --env TYPO3_DB_NAME=typo3 --env TYPO3_DB_USERNAME=db --env TYPO3_DB_PASSWORD=db --env TYPO3_ADMIN_USERNAME=christian --env TYPO3_ADMIN_PASSWORD=christian --env WEB_DOCUMENT_ROOT=/var/www/html --name typo3cms chrisnt5/php-webdevops:1.0.0
```