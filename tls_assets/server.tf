# server.crt
resource "local_file" "etcd_server_crt" {
  content  = tls_locally_signed_cert.server.cert_pem
  filename = "${var.asset_dir}/tls/cluster/server.crt"
}

# server.key
resource "local_file" "etcd_server_key" {
  content  = tls_private_key.server.private_key_pem
  filename = "${var.asset_dir}/tls/cluster/server.key"
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "server" {
  key_algorithm   = tls_private_key.server.algorithm
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = "etcd-server"
    organization = "etcd"
  }

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = concat(var.etcd_servers, ["localhost"])
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem = tls_cert_request.server.cert_request_pem

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
