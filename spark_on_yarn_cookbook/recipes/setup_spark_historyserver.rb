# Modified recipe from
#   Cookbook:: hadoop
#   Recipe:: spark_historyserver

include_recipe 'hadoop::spark2'
pkg = 'spark-history-server'

dfs = node['hadoop']['core_site']['fs.defaultFS']

execute 'hdfs-spark-userdir' do
  command "hdfs dfs -mkdir -p #{dfs}/user/spark && hdfs dfs -chown -R spark:spark #{dfs}/user/spark"
  user 'hdfs'
  group 'hdfs'
  timeout 300
  action :run
  retries 10
  retry_delay 5
end

eventlog_dir =
  if node['spark2']['spark_defaults'].key?('spark.eventLog.dir')
    node['spark2']['spark_defaults']['spark.eventLog.dir']
  else
    'hdfs:///user/spark/applicationHistory'
  end

execute 'hdfs-spark-eventlog-dir' do
  command "hdfs dfs -mkdir -p #{eventlog_dir} && hdfs dfs -chown -R spark:spark #{eventlog_dir} && hdfs dfs -chmod 1777 #{eventlog_dir}"
  user 'hdfs'
  group 'hdfs'
  timeout 300
  retries 10
  retry_delay 5
  action :run
end

spark_log_dir =
  if node['spark2'].key?('spark_env') && node['spark2']['spark_env'].key?('spark_log_dir')
    node['spark2']['spark_env']['spark_log_dir']
  else
    '/var/log/spark'
  end

# Create /etc/default configuration
template "/etc/default/#{pkg}" do
  source 'generic-env.sh.erb'
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  variables options: {
    'spark_home' => "#{hadoop_lib_dir}/spark2",
    'spark_pid_dir' => '/var/run/spark',
    'spark_log_dir' => spark_log_dir,
    'spark_ident_string' => 'spark',
    'spark_history_server_log_dir' => eventlog_dir,
    'spark_history_opts' => '$SPARK_HISTORY_OPTS -Dspark.history.fs.logDirectory=${SPARK_HISTORY_SERVER_LOG_DIR}',
    'spark_conf_dir' => '/etc/spark2/conf',
  }
  cookbook 'hadoop'
end

template "/etc/init.d/#{pkg}" do
  source 'hadoop-init.erb'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  variables options: {
    'desc' => 'Spark History Server',
    'name' => pkg,
    'process' => 'java',
    'binary' => "#{hadoop_lib_dir}/spark2/bin/spark-class",
    'args' => 'org.apache.spark.deploy.history.HistoryServer > ${LOG_FILE} 2>&1 < /dev/null &',
    'confdir' => '${SPARK_CONF_DIR}',
    'user' => 'spark',
    'home' => "#{hadoop_lib_dir}/spark2",
    'pidfile' => "${SPARK_PID_DIR}/#{pkg}.pid",
    'logfile' => "${SPARK_LOG_DIR}/#{pkg}.log",
  }
  cookbook 'hadoop'
end
