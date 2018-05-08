include_recipe 'java::default'
include_recipe 'hadoop::hadoop_hdfs_namenode'
include_recipe 'hadoop::hadoop_yarn_resourcemanager'
include_recipe 'hadoop::hadoop_yarn_nodemanager'
include_recipe 'hadoop::spark2'

template "/usr/lib/systemd/system/hadoop-yarn-resourcemanager.service" do
    owner 'yarn'
    group 'yarn'
    mode '0755'
  end
  
service 'hadoop-yarn-resourcemanager' do
    action %i(enable)
end
  

template "/usr/lib/systemd/system/hadoop-hdfs-namenode.service" do
    owner 'yarn'
    group 'yarn'
    mode '0755'
  end
  
service 'hadoop-hdfs-namenode' do
    action %i(enable)
end
  
template "/usr/lib/systemd/system/spark-history-server.service" do
    owner 'yarn'
    group 'yarn'
    mode '0755'
end
  
service 'spark-history-server' do
    action %i(enable)
end