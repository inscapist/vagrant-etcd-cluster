# etcd-client.crt
resource "local_file" "etcd_client_crt" {
  content  = tls_locally_signed_cert.client.cert_pem
  filename = "${var.asset_dir}/tls/etcd-client.crt"
}

# etcd-client.key
resource "local_file" "etcd_client_key" {
  content  = tls_private_key.client.private_key_pem
  filename = "${var.asset_dir}/tls/etcd-client.key"
}

# client certs are used for client (apiserver, locksmith, etcd-operator)
# to etcd communication
resource "tls_private_key" "client" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "client" {
  key_algorithm   = tls_private_key.client.algorithm
  private_key_pem = tls_private_key.client.private_key_pem

  subject {
    common_name  = "etcd-client"
    organization = "etcd"
  }

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = concat(var.etcd_servers, ["localhost"])
}

resource "tls_locally_signed_cert" "client" {
  cert_request_pem = tls_cert_request.client.cert_request_pem

  ca_key_algorithm   = tls_self_signed_cert.etcd-ca.key_algorithm
  ca_private_key_pem = tls_private_key.etcd-ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.etcd-ca.cert_pem

  validity_period_hours = var.certificate_validity

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}
