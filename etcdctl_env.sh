#!/bin/bash

echo "# Usage: ./etcdctl_env.sh | source"

echo "export ETCDCTL_API=3
export ETCDCTL_CACERT=tls_assets/tls/etcd-ca.crt
export ETCDCTL_CERT=tls_assets/tls/etcd-client.crt
export ETCDCTL_KEY=tls_assets/tls/etcd-client.key
export ETCDCTL_ENDPOINTS=https://127.0.0.1:2380,https://127.0.0.1:2381,https://127.0.0.1:2382"
