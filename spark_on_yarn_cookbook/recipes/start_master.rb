# This recipe will initialize and restart the service
execute 'hdfs-namenode-format' do
    command 'hdfs namenode -format -nonInteractive -clusterId ' + node['org']['environment_prefix']
    action :run
    group 'hdfs'
    user 'hdfs'
    timeout 3000
    retries 10
    retry_delay 5
    ignore_failure true
end

node.override['hadoop']['yarn_site']['yarn.resourcemanager.hostname'] = "#{node['org']['environment_prefix']}-spark-cluster-master.#{node['org']['internal_dns']}"
# By Default If Port is not appended it will use 8020
node.override['hadoop']['core_site']['fs.defaultFS'] = "hdfs://#{node['org']['environment_prefix']}-spark-cluster-master.#{node['org']['internal_dns']}"
hadoop_conf_dir = "/etc/hadoop/#{node['hadoop']['conf_dir']}"

%w(core_site yarn_site).each do |sitefile|
    template "#{hadoop_conf_dir}/#{sitefile.tr('_', '-')}.xml" do
      source 'generic-site.xml.erb'
      mode '0644'
      owner 'root'
      group 'root'
      action :create
      variables options: node['hadoop'][sitefile]
      only_if { node['hadoop'].key?(sitefile) && !node['hadoop'][sitefile].empty? }
      cookbook 'hadoop'
    end
end

service 'hadoop-yarn-resourcemanager' do
   action [:stop , :start]
end

service 'hadoop-hdfs-namenode' do
    action [:stop, :start]
end
  
# Spark History server setup
include_recipe 'spark_on_yarn_cookbook::setup_spark_historyserver'

service 'spark-history-server' do
    action [:stop, :start]
end
