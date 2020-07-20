Журнал работ

01.07.2020
[1](https://github.com/vasiliev-alexey/otus_devops_project/issues/1) - Знакомство с исходными кодами
Скачать исходные коды. Проссмотеть их. Попробовать позапускать. Загрузить в репозитрий
[2](https://github.com/vasiliev-alexey/otus_devops_project/issues/2) - Контейнеризировать приложение. Локальная сборка и запуск
[4](https://github.com/vasiliev-alexey/otus_devops_project/issues/4) - Подключить к приложению мониторинг Prometheus + cadvisor

02.07.2020
Создан CI\CD на оснвании GitHub Actions
- пайплайн по сборке проекта (пока без пушей)
- пайплайн по юнит-тестам
- пайплайн по проверка на покрытие тестами


04.07
Написаны Helm  чарты  для приложения

05.07
Написана конфигурация Terraform для сошдания K8s кластера в GKE

07.07
Написаны скрипты деплоя в  k8s

09.07
Создан и протетсирован helm   chart Prometheus

10.07 
Наконец то удалось настроить  provision через Helm
Настроил деплой  helm  chart-ов через  terraform

11.07
Настроен деплой дашбордов графаны  через helm-chart  в terraform
Разобрался и настроил  мониторинг   rabbitmq через  prometheus exporter (надо влючить плагин в RQ)

12.07
Добавлен экспортер для Mongo
Разобрался и настроил  мониторинг   Mongo через  prometheus exporter
Добавлены дашборды  для Mongo и Rabbit в Terraform


16.07
Добавлено логирование через Fluentd + Loki + Grafana для Docker-Compose

18.07
Инфраструктурные сервисы мониторинга вынесены в модуль.
Модуль переиспользован в Terraform  сценариях для Minikube и GKE
Добавлено централизованое логирование через Fluend + Loki + Grafana -  правда пока без структурирования логов

18.07
Добавлен ChatOps  в GitHub Actions


TODO
Создать докуммент как запустить проект
