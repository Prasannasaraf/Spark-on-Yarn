Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.2"
  config.ssh.forward_agent = true
  
  config.vm.define "slave-2" do |node|
    node.vm.provision "chef_solo" do |chef|
      chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym
      chef.json = {
        "org" => {
          "environment_prefix" => "local",
          "internal_dns" => "org.local"
        }
      }
      chef.node_name = "local-spark-cluster-slave02"
      chef.add_recipe "test_setup::ipaddress"
      chef.add_recipe "spark_on_yarn_cookbook::setup_slave"
      chef.add_recipe "spark_on_yarn_cookbook::start_slave"
    end
    node.vm.network "private_network", ip: "192.168.33.45"
    node.vm.network "forwarded_port", guest: 22, host: 2245, id: "ssh"
    node.vm.provider "virtualbox" do |v|
      v.name = "slave-2"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define "slave-1" do |node|
    node.vm.provision "chef_solo" do |chef|
      chef.json = {
        "org" => {
          "environment_prefix" => "devbox",
          "internal_dns" => "org.local"
        }
      }
      chef.node_name = 'local-spark-cluster-slave01'
      chef.add_recipe "test_setup::ipaddress"
      chef.add_recipe "spark_on_yarn_cookbook::setup_slave"
      chef.add_recipe "spark_on_yarn_cookbook::start_slave"
    end
    node.vm.network "private_network", ip: "192.168.33.44"
    node.vm.network "forwarded_port", guest: 22, host: 2244, id: "ssh"
    node.vm.provider "virtualbox" do |v|
      v.name = "slave-1"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define "master" do |node|
    node.vm.provision "chef_solo" do |chef|
      chef.json = {
        "org" => {
          "environment_prefix" => "local",
          "internal_dns" => "org.local"
        }
      }
      chef.node_name = 'local-spark-cluster-master'
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "test_setup::ipaddress"
      chef.add_recipe "spark_on_yarn_cookbook::setup_master"
      chef.add_recipe "spark_on_yarn_cookbook::start_master"
    end 
    node.vm.network "private_network", ip: "192.168.33.43"
    node.vm.network "forwarded_port", guest: 22, host: 2243, id: "ssh"
    node.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end
end

