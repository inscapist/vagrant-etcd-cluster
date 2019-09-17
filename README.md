# Vagrant Etcd Cluster

## Common Operations
Login into one of the etcd instance and:

#### Transpile container linux config (CLC) to ignition (IGN)
```bash
ct -in-file etcd_dev_1.yaml > etcd_dev_1.ign
```

#### SSH
```bash
vagrant ssh core1
vagrant ssh core2
vagrant ssh core3
```

#### iTerm2 fix
If you are using iTerm2, cli behavior might be weird. Setting `export TERM=vt100` should fix it.

#### Use etcdctl
Set api version to 3 because we are using etcd 3.4.0
```bash
export ETCDCTL_API=3
```

#### Debug
```bash
# either
journalctl -u etcd-member
journalctl -u etcd-member -n 100 --no-pager
```

## Important things to note
- Always remove unhealthy node before adding new one
- Monitor disk usage

## Reference links
[Possible Failure Scenarios](https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/failures.md)
[Security](https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/security.md)
[TLS setup](https://github.com/etcd-io/etcd/tree/master/hack/tls-setup)
[Deploying on AWS](https://github.com/etcd-io/etcd/blob/master/Documentation/platforms/aws.md)
[Operating etcd on kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)