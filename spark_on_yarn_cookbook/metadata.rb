name 'spark_on_yarn_cookbook'
maintainer 'Prasanna Saraf'
maintainer_email 'prasannasaraf180@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures Spark-on-yarn-cookbook'
long_description 'Installs/Configures Spark-on-yarn-cookbook'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# External Dependencies
depends 'java', '= 1.45.0'
depends 'hadoop', '~> 2.13.0'
