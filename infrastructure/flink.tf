resource "kubernetes_service_account" "flink" {
  metadata {
    name      = "flink"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role_binding" "flink-operator" {
  depends_on = [
    helm_release.flink
  ]
  metadata {
    name = "flink-operator"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "flink-operator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "flink"
    namespace = "default"
  }
}

resource "helm_release" "flink" {
  depends_on = [
    azurerm_kubernetes_cluster.this,
    helm_release.cert_manager
  ]
  name              = "flink-operator-repo"
  repository        = "https://downloads.apache.org/flink/flink-kubernetes-operator-1.4.0"
  chart             = "flink-kubernetes-operator"
  namespace         = "flink"
  create_namespace  = true
}

resource "helm_release" "cert_manager" {
  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
  name              = "jetstack"
  repository        = "https://charts.jetstack.io"
  chart             = "cert-manager"
  namespace         = "cert-manager"
  create_namespace  = true
  version           = "v1.8.2"

  set {
    name  = "installCRDs"
    value = true
  }
}