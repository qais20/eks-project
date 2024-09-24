resource "helm_release" "ingress_nginx" {
  name             = local.nginx_ingress_name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  values = [
    file("./helm/ingress/values.yaml")
  ]

  set {
    name  = "controller.service.loadBalancerIP"
    value = module.dns.public_ip
  }

  lifecycle {
    ignore_changes = [
      set,
    ]
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.24.1"
  namespace  = "argocd"
}

resource "helm_release" "cert_manager" {
  name             = local.cert_manager_name
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.13.3"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}