env = ENV['ENV'] || 'dev'
p 'ENV : ' + env

solver :ruby, :required
source 'https://supermarket.chef.io'

cookbook "spark_on_yarn_cookbook", path: "./spark_on_yarn_cookbook"
cookbook "test_setup", path: "./test_setup"
cookbook 'hostsfile', '= 0.1.1'
