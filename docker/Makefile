build-all: build-engine build-ui

build-engine:
	cd ../src/search_engine_crawler && bash ./docker_build.sh
build-ui:
	cd ../src/search_engine_ui && bash ./docker_build.sh

build-prom:
	cd ./monitoring/prometheus && docker build -t ${USER_NAME}/crawler_prometheus .

build-mongodb_exporter:
	cd ./monitoring/mongodb_exporter && docker build -t ${USER_NAME}/crawler_mongodb_exporter .

build-rabbitmq_exporter:
	cd ./monitoring/rabbitmq_exporter && docker build -t ${USER_NAME}/crawler_rabbit_exporter .