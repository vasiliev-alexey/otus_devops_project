# otus_devops_project
![Тесты исходного кода](https://github.com/vasiliev-alexey/otus_devops_project/workflows/%D0%A2%D0%B5%D1%81%D1%82%D1%8B%20%D0%B8%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D0%BE%D0%B3%D0%BE%20%D0%BA%D0%BE%D0%B4%D0%B0/badge.svg?event=push)

![Оценка покрытия тестами](https://github.com/vasiliev-alexey/otus_devops_project/workflows/%D0%9E%D1%86%D0%B5%D0%BD%D0%BA%D0%B0%20%D0%BF%D0%BE%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F%20%D1%82%D0%B5%D1%81%D1%82%D0%B0%D0%BC%D0%B8/badge.svg)



## Требования / TODO
 - [x] Автоматизированные процессы создания и управления платформой  
      - [x] Ресурсы GCP  
      - [x] Инфраструктура для CI/CD  
      - [x] Инфраструктура для сбора обратной связи  
 - [x] Использование практики IaC для управления конфигурацией и инфраструктурой
     - Промышленная инфраструктура создается  помощью Terraform в GKE и  и обновляется инфраструктурными        сервисами с помощью Terraform-Helm
     - Для стейджинга - можно применять тот же кластер в Miniicube (для этого написаны отдедбные Helm чарты) , GKE  или создать аналогичный  или исползоввать продуктовый, но с разными namespacame (не реализовано, но заложено - для приложений и инфраструктуры - разные неймспейсы)
      -  Для Developer  окружения написан Makefile для билда  контейнеров  из исходников и пуш их в DockerHub
 - [x] Настроен процесс CI/CD
     -   Реализована локальная сборка Docker контейнеров на  локальной машине DEV\QA. Написан DockerCompose для создания продуктового окружения в локальной среде из собранных контейнеров
     -   Реализована Автоматическая сборка. сохраение в GKE (Google Container Registry) и деплой в созданный кластер GKE. Pipeline  реализован через GitHub Actions (используется  плагин от GoogleCloudPlatform  kubectl + kustomize)  
     -  При коммите исходного кода из  дерриктории SRC  настроее pipeline для проведения Unit-тестирования и оуенки покрытия кода UNIT-тестами (испольузется GitHub Actions)
     -  Infra 
         -  Terraform + Helm
         -  Docker + DockerCompose
     -  Deploy
         -  Minikube: Helm
         -  GKE: Github Actions + GCR + cubectl + kustommize
         -  DEV-env: Make + DockerCompose
 - [x] Все, что имеет отношение к проекту хранится в Git
 - [x] Настроен процесс сбора обратной связи
     - [x] Мониторинг
         - [x] сбор метрик (Prometheus + Grafana)
         - [ ] алертинг
         - [x] визуализация (Grafana)
     - [x] Логирование (Fluentd + Loki + Grafana)
     - [ ] Трейсинг (опционально)
     - [ ] ChatOps (опционально)
 - [ ] Документация
     - [ ] README по работе с репозиторием
         - [ ] Описание приложения и его архитектуры
         - [ ] CI/CD
             - [ ] Pipeline
                 - [x] Пример рабочего флоу
         - [ ] How to start?
             - [ ] CI/CD Environment Variables
     - [x]  [CHANGELOG](./docs/Журнал работ.md) с описанием выполненной работы 
