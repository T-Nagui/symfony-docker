# Makefile

cmd=""
path="src"
OS := $(shell uname)

up:
	docker-compose down &&  docker-compose -f docker-compose.yml up -d --remove-orphans --force-recreate

down:
	docker-compose down

bash:
	docker exec -it app_php bash
init:
	docker exec -it app_php bash -c 'composer install -vvv \
	&& php bin/console do:mi:mi \
	&& php bin/console cache:clear'

load-fixtures:
	docker exec -it app_php bash -c 'php bin/console doctrine:fixtures:load'

# exemple make sf cmd=cache:clear
sf:
	docker exec -it app_php bash -c 'php bin/console $(cmd)'
phpcs:
	docker exec -it app_php bash -c ' vendor/bin/php-cs-fixer fix $(path)'

mysql:
	docker-compose exec mysql bash -c 'mysql -u root -proot -D app'

logit:
	make up && docker-compose logs -f