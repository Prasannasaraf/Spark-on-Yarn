# Spark-on-yarn-cookbook
This is a wrapper coookbook over hadoop cookbook

This setup creates 3 vagrant boxes with 1 master and 2 slaves

## Instructions
To setup the cluster
  1. berks vendor cookbooks
  1. vagrant up --provison

To destroy the cluster
  1. vagrant destroy -y

## To View Web Interfaces Hosted on this Cluster

Append the following in /etc/hosts file

192.168.33.43        local-spark-cluster-master.org.local local-spark-cluster-master
192.168.33.44        local-spark-cluster-slave01.org.local local-spark-cluster-slave01
192.168.33.45        local-spark-cluster-slave02.org.local local-spark-cluster-slave02

|Machine|Name of interface|URI|
|-------|-----------------|---|
|Master|YARN ResourceManager|	http://local-spark-cluster-master.org.local:8088/|
|Slave01|YARN NodeManager|	http://local-spark-cluster-slave01.org.local:8042/|
|Slave02|YARN NodeManager|	http://local-spark-cluster-slave02.org.local:8042/|
|Master|Hadoop HDFS NameNode|	http://local-spark-cluster-master.org.local:50070/|
|Slave01|Hadoop HDFS DataNode|	http://local-spark-cluster-slave01.org.local:50075/|
|Slave02|Hadoop HDFS DataNode|	http://local-spark-cluster-slave02.org.local:50075/|
|Master|Spark HistoryServer|	http://local-spark-cluster-master.org.local:18080/|



## Services
 As part of this setup follwing services are configured 

Master
  1. HDFS Namenode
  1. YARN Resourcemanager
  1. Spark History Server

Slave
  1. HDFS Datanode
  1. YARN Nodemanager
