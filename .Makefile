NAME = wp_test

all: deploy

deploy:
	docker stack deploy -c docker-compose.yml $(NAME)

rm:
	docker stack rm $(NAME)
