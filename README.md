# Vagrant Etcd Cluster

## Common Operations

#### Transpile container linux config (yaml) to ignition (ign)
```bash
ct -in-file etcd_dev_1.yaml > etcd_dev_1.ign
```

#### SSH
```bash
vagrant ssh core1
vagrant ssh core2
vagrant ssh core3
```


#### Use etcdctl
On the project root
```bash
# load etcdctl environment variables
./etcdctl_env.sh | source

# list/add/rm members
etcdctl member list
etcdctl member add xyz
etcdctl member remove xyz

# check endpoints
etcdctl endpoint health
etcdctl endpoint status

# snapshot
etcdctl snapshot save etcd.snapshot # save as etcd.snapshot
etcdctl snapshot status etcd.snapshot # inspect
etcdctl snapshot restore etcd.snapshot

# add path
etcdctl put /hello 5

# list from prefix
etcdctl get / --prefix --keys-only

# get specific key
etcdctl get /hello
```

#### Debug
```bash
# either
journalctl -u etcd-member
journalctl -u etcd-member -n 100 --no-pager
```

## Some Pecularities

#### 1. etcdmain unable to open crt
https://github.com/etcd-io/etcd/issues/9145#issuecomment-425506094

#### 2. iTerm2 fix
If you are using iTerm2, cli behavior might be weird. Setting `export TERM=vt100` should fix it.

## Important things to note
- Always remove unhealthy node before adding new one
- Monitor disk usage

## Reference links
[Possible Failure Scenarios](https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/failures.md)
[Security](https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/security.md)
[TLS setup](https://github.com/etcd-io/etcd/tree/master/hack/tls-setup)
[Deploying on AWS](https://github.com/etcd-io/etcd/blob/master/Documentation/platforms/aws.md)
[Operating etcd on kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)