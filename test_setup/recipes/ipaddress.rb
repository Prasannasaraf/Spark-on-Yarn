hostsfile_entry '192.168.33.43' do
    hostname "#{node['org']['environment_prefix']}-spark-cluster-master.#{node['org']['internal_dns']} #{node['org']['environment_prefix']}-spark-cluster-master"
    action :create
end

hostsfile_entry '192.168.33.44' do
    hostname "#{node['org']['environment_prefix']}-spark-cluster-slave01.#{node['org']['internal_dns']} #{node['org']['environment_prefix']}-spark-cluster-slave01"
    action :create
end

hostsfile_entry '192.168.33.45' do
    hostname "#{node['org']['environment_prefix']}-spark-cluster-slave02.#{node['org']['internal_dns']} #{node['org']['environment_prefix']}-spark-cluster-slave02"
    action :create
end

hostname = node.name
file '/etc/hostname' do
    content "#{hostname}\n"
    mode '0644'
    notifies :reload, 'ohai[reload_hostname]', :immediately
end

ohai 'reload_hostname' do
    plugin 'hostname'
    action :nothing
end