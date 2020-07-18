terraform {
  required_version = ">= 0.12.26"
}

provider "helm" {
  version = "~> 1.00"

}


resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "../helm/nginx"
  namespace = "nginx-ingress"
  create_namespace = true
  depends_on =   [var.vm_depends_on]
 
}


resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "../helm/prometheus"
  namespace = "monitoring"
  create_namespace = true

depends_on =   [var.vm_depends_on]
 

}


resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "../helm/grafana"
  namespace = "monitoring"
  create_namespace = true
depends_on =   [var.vm_depends_on]
}

resource "helm_release" "rabbitmq-exporter" {
  name       = "rabbitmq-exporter"
  chart = "stable/prometheus-rabbitmq-exporter"
  namespace = "monitoring"
  create_namespace = true
  version = "0.5.5"
  values = [
    "${file("../helm/prometheus-rabbitmq-exporter/values.yaml")}"
  ]
  depends_on =   [var.vm_depends_on]
}

resource "helm_release" "mongodb-exporter" {
  name       = "mongodb-exporter"
  chart = "stable/prometheus-mongodb-exporter"
  namespace = "monitoring"
  create_namespace = true
  depends_on = [
   helm_release.prometheus,
   var.vm_depends_on
  ]
  values = [
    "${file("../helm/prometheus-mongodb-exporter/values.yaml")}"
  ]
 
}

resource "helm_release" "loki" {
  name       = "loki"
  chart      = "loki"
  repository = "https://grafana.github.io/loki/charts" 
  namespace = "monitoring"
  create_namespace = true
depends_on =   [var.vm_depends_on]
}

resource "helm_release" "loki-fluent-bit" {
  name       = "fluent-bit"
  chart      = "fluent-bit"
  repository = "https://grafana.github.io/loki/charts" 
  namespace = "monitoring"
  create_namespace = true
depends_on =   [var.vm_depends_on]

  set {
    name  = "loki.serviceName"
    value = "loki.monitoring.svc.cluster.local"
  }


}
