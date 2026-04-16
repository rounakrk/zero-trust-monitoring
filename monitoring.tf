resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "56.0.0"

  # Integration safety: Ensures the namespace exists first
  depends_on = [kubernetes_namespace_v1.monitoring]

  values = [
    file("values.yaml")
  ]
}