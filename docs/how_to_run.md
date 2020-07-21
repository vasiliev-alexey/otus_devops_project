# Как запустить проект

## Локальный запуск в DEV среде

Для зпуска в среде разработки:

0. Предусловие - установлен:
    * make
    * docker
    * docker-compose

1. Собрать контейнеры с помощью утилиты Make и [Makefile](docker/Makefile)
2. Запустить приложение, находясь в директории docker
    - только приложение  

            docker-compose -f docker-compose.yml up
    - добавить инфраструктуру  для монитринга 

            docker-compose -f docker-compose-monitoring.yml up
     - добавить инфраструктуру  для логирование

             docker-compose -f docker-compose-logging.yml up     
  
## Запуск в minikube

0. Предусловие - установлен:
    * minikube
    * terraform
    * helm

1. Поднимаем k8s в minikube

        minikube start 

2. Деплоим инфраструктуру для логироваия и мониторинга (опционально)
    
        cd infra/minikube
        terraform inin && terraform apply -auto-approve  

3. Деплоим приложение

        cd ./helm
        helm upgrade --install app .

4. Пробрасываем порт и смотрим за проложением

## Запуск для GKE

0. Предусловие - установлен:
    * terraform
    * gcloud CLI  && Cloud SDK
    * произведена авторизация в https://cloud.google.com/
    * cоздан сервисный акаунт в GCP  с ролями (Kubernetes Engine Developer , Storage Admin) 
    * в проекте на GitHub для репозитория  созданы секреты 
        * GKE_PROJECT - код проекта в GCP
        * GKE_SA_KEY -  JSON сервисного акаунта в GCP
        * SLACK_WEBHOOK - созданный web-hook Slack для нотификации


1. Создаем кластер  k8s

        cd infra/gke
        terraform inin && terraform apply -auto-approve  

2. Деплоим приложение
        
    * приложение деплоится автоматически при коммите в ветку мастер (плохо) или при пул-реквестах в ветку мастер, если изнмение произошло в  папке src
        для примера изменяем  файл src/release.file
      
          git add src/release.file && git commit -m "test fix" && git push

    * автоматически в GitHub Actions выполнятся сценарии тестирования. сборки и деплоя в GKE.
    * Нотификации будут приходить в канал в слак - пока по факту успешной сборки и развертывания.

