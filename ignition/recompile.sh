#!/bin/bash

rm -f *.merged
rm -f *.ign

ct -in-file etcd_dev_1.yaml >etcd_dev_1.ign
ct -in-file etcd_dev_2.yaml >etcd_dev_2.ign
ct -in-file etcd_dev_3.yaml >etcd_dev_3.ign
