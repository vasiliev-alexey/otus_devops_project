terraform {
  required_version = ">= 0.12.26"
}

provider "helm" {
  version = "~> 1.00"

}

provider "google" {
  version = "~> 3.15.0"
  project = var.project_name
  region  = var.region_name
}

 

resource "google_container_cluster" "av-k8s-cluster" {
  name     = "av-k8s-cluster"
  location = var.location_name

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

 provisioner "local-exec" {
    command = "gcloud container clusters get-credentials av-k8s-cluster --zone europe-west1-b --project inbound-coast-275214"
  }

}

resource "google_container_node_pool" "av-k8s-nodes" {
  name       = "av-k8s-node-pool"
  location   = var.location_name
  cluster    = google_container_cluster.av-k8s-cluster.name
  node_count = var.count_vms

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"
    disk_size_gb = 30

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "../helm/nginx"
  namespace = "nginx-ingress"
  create_namespace = true
  depends_on = [
   google_container_node_pool.av-k8s-nodes
  ]

}


resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "../helm/prometheus"
  namespace = "monitoring"
  create_namespace = true

  depends_on = [
   google_container_node_pool.av-k8s-nodes
  ]

}


resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "../helm/grafana"
  namespace = "monitoring"
  depends_on = [
   google_container_node_pool.av-k8s-nodes
  ]

}

resource "helm_release" "rabbitmq-exporter" {
  name       = "rabbitmq-exporter"
  chart = "stable/prometheus-rabbitmq-exporter"
  namespace = "monitoring"
  version = "0.5.5"
  depends_on = [
   google_container_node_pool.av-k8s-nodes
  ]
  values = [
    "${file("../helm/prometheus-rabbitmq-exporter/values.yaml")}"
  ]
}
