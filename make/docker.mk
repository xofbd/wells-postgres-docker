include .config

docker_image := wells
docker_container := postgres_wells

.PHONY: docker-image
docker-image:
	docker build -t $(docker_image) .

.PHONY: docker-run
docker-run: docker-image
	docker run --name $(docker_container) -d -p $(PORT):5432 --rm -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) $(docker_image)

.PHONY: docker-stop
docker-stop:
	docker container stop $(docker_container)

.PHONY: docker-shell
docker-shell:
	docker exec -it $(docker_container) bash
