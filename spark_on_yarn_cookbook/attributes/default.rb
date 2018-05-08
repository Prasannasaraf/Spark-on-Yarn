default['java']['jdk_version'] = '8'
default['hadoop']['core_site']['hadoop.tmp.dir'] = '/hadoop'
default['hadoop']['distribution_version'] = '2.6'

# This is needs to overridden to master dns
default['hadoop']['core_site']['fs.defaultFS'] = ''

default['hadoop']['hdfs_site']['dfs.namenode.datanode.registration.ip-hostname-check'] = false

default['hadoop']['yarn_site']['yarn.application.classpath'] = '/usr/hdp/current/spark2-client/aux/*,/etc/hadoop/conf,/usr/hdp/current/hadoop-client/*,/usr/hdp/current/hadoop-client/lib/*,/usr/hdp/current/hadoop-hdfs-client/*,/usr/hdp/current/hadoop-hdfs-client/lib/*,/usr/hdp/current/hadoop-yarn-client/*,/usr/hdp/current/hadoop-yarn-client/lib/*'
default['hadoop']['hadoop_env']['hadoop_classpath'] =
  if node['hadoop'].key?('hadoop_env') && node['hadoop']['hadoop_env'].key?('hadoop_classpath')
    "$HADOOP_CLASSPATH:#{node['hadoop']['hadoop_env']['hadoop_classpath']}:/usr/hdp/current/spark2-client/aux/*"
  else
    "$HADOOP_CLASSPATH:/usr/hdp/current/spark2-client/aux/*"
  end

# Spark Shuffle Service
default['hadoop']['yarn_site']['yarn.nodemanager.aux-services'] = 'spark_shuffle'
default['hadoop']['yarn_site']['yarn.nodemanager.aux-services.spark_shuffle.class'] = 'org.apache.spark.network.yarn.YarnShuffleService'