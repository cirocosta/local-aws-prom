run-prometheus:
	MACHINE_IP=$(shell ./docker/get-ip.py) \
		docker-compose \
			-f ./docker/compose.yml \
			up -d 

run-vms:
	cd ./vagrant && \
		vagrant up

.PHONY: run-vms run-prometheus
