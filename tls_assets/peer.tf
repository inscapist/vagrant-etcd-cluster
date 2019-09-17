# peer.crt
resource "local_file" "etcd_peer_crt" {
  content  = tls_locally_signed_cert.peer.cert_pem
  filename = "${var.asset_dir}/tls/cluster/peer.crt"
}

# peer.key
resource "local_file" "etcd_peer_key" {
  content  = tls_private_key.peer.private_key_pem
  filename = "${var.asset_dir}/tls/cluster/peer.key"
}

resource "tls_private_key" "peer" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "peer" {
  key_algorithm   = tls_private_key.peer.algorithm
  private_key_pem = tls_private_key.peer.private_key_pem

  subject {
    common_name  = "etcd-peer"
    organization = "etcd"
  }

  dns_names = var.etcd_servers
}

resource "tls_locally_signed_cert" "peer" {
  cert_request_pem = tls_cert_request.peer.cert_request_pem

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
