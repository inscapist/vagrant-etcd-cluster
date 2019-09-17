# Vagrant Etcd Cluster

## Cluster design criteria

#### Stateful
Stateful component is best dealt with manually. For that, we do not use AutoScalingGroup. Recovery, upgrades etc should be done manually instead of relying on Operator.

#### Performance Consistency
It is best to preallocate IOPS and networking bandwidth. For that, we can use provisionedIOps and EC2 enhanced networking.

#### Data Durability
Point in time snapshotting should be implemented. Periodic EBS snapshot should also be implemented as redundant recovery measure.

#### Monitoring
The uptime of etcd should be monitored and if downtime happens, notify the engineers.

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

## Common etcdctl calls

## Important things to note
- Always remove unhealthy node before adding new one
- Monitor disk usage

## Reference links
[Deploying on AWS](https://github.com/etcd-io/etcd/blob/master/Documentation/platforms/aws.md)
[Operating etcd on kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)
[Possible Failure Scenarios](https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/failures.md)
