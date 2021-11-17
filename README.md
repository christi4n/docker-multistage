## Purpose of this repo

This repo allows you to run a sample LAMP instance with the TYPO3 CMS.
There's a .env file at the root so you can specify your own variables.
The project generates also a Docker image thanks to the Dockerfile in it and the resulted image can be mounted in a Kubernetes pod.

There are four variable types:
- TYPO3 context
- DB configuration (you have to run a dedicated container for MySQL)
- Mail
- SYS configuration for TYPO3

Basically, you have to be in the project root directory to launch the following CLI commands.
To run the image, you have to mount the app directory project folder into /var/www

Default URL for testing: http://typo3.testing/
Use dnsmasq or edit your /etc/hosts file to reach the website or use localhost.

### Screenshots

Here is what you should expect:

#### Backend

![TYPO3 v11 backend](https://raw.githubusercontent.com/christi4n/docker-multistage/feature/master/assets/multistage-typo3-v11-backend.png)

#### Frontend

![TYPO3 v11 frontend](https://raw.githubusercontent.com/christi4n/docker-multistage/feature/master/assets/multistage-typo3-v11-frontend.png)
### 2.0.3

This version is using TYPO3 v11.

Build the new image based on TYPO3 v11:

```
docker build --no-cache -t chrisnt5/php-webdevops:2.0.3 .
```

Run the typo3-cms container with the following command:

```
docker run -d -p 80:80 -v $PWD/app:/var/www --network typo3-db --env TYPO3_DB_HOST=typo3-mysql --env TYPO3_DB_NAME=typo3 --env TYPO3_DB_USERNAME=db --env TYPO3_DB_PASSWORD=db --env TYPO3_ADMIN_USERNAME=christian --env TYPO3_ADMIN_PASSWORD=christian --env WEB_DOCUMENT_ROOT=/var/www/public --env WEB_DOCUMENT_INDEX=index.php --env-file .env --name typo3cms chrisnt5/php-webdevops:2.0.3
```

Or better, use the .env file for environment variables:

```
docker run -d -p 80:80 --network typo3-db --env-file .env --name typo3cms chrisnt5/php-webdevops:2.0.3
```

### Sample database

In case you need to import the default database, use this TYPO3 admin credentials:

Username: db
Password: db

### TODO:

    - import the DB from the db directory
    - create an admin user with the CLI and the env variables. Use helhum/typo3-console and backend:createadmin
