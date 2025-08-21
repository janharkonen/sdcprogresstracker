run_dev:
	docker compose build sveltefrontend-dev nginx-dev redis
	docker compose up sveltefrontend-dev nginx-dev redis
stop_dev:
	docker compose down --rmi local --volumes --remove-orphans
	docker ps -a
	docker image ls -a
run_prod:
	docker compose build sveltefrontend nginx redis
	docker compose up sveltefrontend nginx redis
stop_prod:
	docker compose down --rmi local --volumes --remove-orphans
	docker ps -a
	docker image ls -a
rediscli:
	docker exec -it rediscontainer redis-cli