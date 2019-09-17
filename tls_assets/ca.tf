# etcd-ca.crt
resource "local_file" "etcd_ca_crt" {
  content  = tls_self_signed_cert.etcd-ca.cert_pem
  filename = "${var.asset_dir}/tls/etcd-ca.crt"
}

# copy ca.crt to etcd cluster
resource "local_file" "ca_crt" {
  content  = tls_self_signed_cert.etcd-ca.cert_pem
  filename = "${var.asset_dir}/tls/cluster/ca.crt"
}

# etcd-ca.key
resource "local_file" "etcd_ca_key" {
  content  = tls_private_key.etcd-ca.private_key_pem
  filename = "${var.asset_dir}/tls/etcd-ca.key"
}


resource "tls_private_key" "etcd-ca" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "etcd-ca" {
  key_algorithm   = tls_private_key.etcd-ca.algorithm
  private_key_pem = tls_private_key.etcd-ca.private_key_pem

  subject {
    common_name  = "etcd-ca"
    organization = "etcd"
  }

  is_ca_certificate     = true
  validity_period_hours = var.certificate_validity

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}
