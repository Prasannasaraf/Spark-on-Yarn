node.override['hadoop']['yarn_site']['yarn.resourcemanager.hostname'] = "#{node['org']['environment_prefix']}-spark-cluster-master.#{node['org']['internal_dns']}"
node.override['hadoop']['yarn_site']['yarn.nodemanager.hostname'] = "#{node.name}.#{node['org']['internal_dns']}"
node.override['hadoop']['core_site']['fs.defaultFS'] = "#{node['org']['environment_prefix']}-spark-cluster-master.#{node['org']['internal_dns']}"

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

include_recipe 'hadoop::default'

service 'hadoop-yarn-nodemanager' do
    action [:stop, :start]
end

service 'hadoop-hdfs-datanode' do
    action [:stop, :start]
end




