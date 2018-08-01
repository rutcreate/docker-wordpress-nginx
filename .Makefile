NAME = wp_test

all: run

run:
	docker stack deploy -c docker-compose.yml $(NAME)

rm:
	docker stack rm $(NAME)
