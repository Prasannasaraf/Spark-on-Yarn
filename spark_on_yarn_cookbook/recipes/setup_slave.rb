include_recipe 'java::default'
include_recipe 'hadoop::hadoop_yarn_nodemanager'
include_recipe 'hadoop::hadoop_hdfs_datanode'

template "/usr/lib/systemd/system/hadoop-yarn-nodemanager.service" do
    owner 'yarn'
    group 'yarn'
    mode '0755'
end
  
service 'hadoop-yarn-nodemanager' do
    action %i(enable)
end
  
  
template "/usr/lib/systemd/system/hadoop-hdfs-datanode.service" do
    owner 'yarn'
    group 'yarn'
    mode '0755'
end
  
service 'hadoop-hdfs-datanode' do
    action %i(enable)
end
