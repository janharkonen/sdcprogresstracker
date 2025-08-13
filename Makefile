run_dev:
	docker compose build sveltefrontend-dev nginx-dev
	docker compose up sveltefrontend-dev nginx-dev
stop_dev:
	docker compose down
	docker image rmi sdcprogresstracker-sveltefrontend-dev:latest 
	docker image rmi nginx:alpine 
	docker ps -a
	docker image ls -a
