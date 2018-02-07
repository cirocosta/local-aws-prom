run-prometheus-aws:
	docker-compose \
		-f ./docker/compose-aws.yml \
		up -d --build

run-prometheus-locally:
	MACHINE_IP=$(shell ./docker/get-ip.py) \
		docker-compose \
			-f ./docker/compose.yml \
			up -d --build

run-vms:
	cd ./vagrant && \
		vagrant up

.PHONY: run-vms run-prometheus-locally run-prometheus-aws
