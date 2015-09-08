#
# Cookbook Name:: mysql_config
# Recipe:: start_replication
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

opts = data_bag_item('mysql', node['mysql_config']['databag_name'])
slvopts = data_bag_item('mysql', 'slave')
replopts = data_bag_item('mysql', 'replication')

mysql_connection_info = {
  :host => 'localhost',
  :username => 'root',
  :password => opts['password'],
  :socket => '/tmp/mysqld.sock'
}

mysql_database_user 'repl' do
  connection mysql_connection_info
  host '10.84.%'
  password replopts['password']
  privileges ['replication slave']
  action :grant
  only_if { node['mysql_config']['instance_name'] == 'master' }
end

if node['mysql_config']['instance_name'] == 'slave'
  bash 'start replication' do
    user 'mysql'
    code <<-EOF
    mysql -uroot -p#{slvopts['password']} -S /tmp/mysqld.sock -e "change master to master_host = '10.84.101.100',
    master_log_file = 'mysql-bin.000001',
    master_log_pos = 120,
    master_user = 'repl',
    master_password = '#{replopts['password']}',
    master_port = 3306;
    start slave;"
    EOF
    not_if "mysql -uroot -p#{slvopts['password']} -S /tmp/mysqld.sock -e
    'select * from information_schema.global_status where variable_name like \"slave_running\";' | grep ON"
    action :run
  end
end
