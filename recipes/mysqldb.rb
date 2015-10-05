#
# Cookbook Name:: mysql_config
# Recipe:: mysqldb
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

opts = data_bag_item('mysql', node['mysql_config']['databag_name'])
include_recipe 'iptables'

iptables_rule 'mysql' do
  source 'mysql_3306'
end

mysql_service node['mysql_config']['instance_name'] do
  port node['mysql_config']['port']
  version '5.6'
  data_dir '/data/mysql'
  tmp_dir '/tmp/shm'
  error_log '/logs/mysql/mysql.err'
  socket '/tmp/mysqld.sock'
  pid_file '/tmp/mysqld.pid'
  bind_address '0.0.0.0'
  initial_root_password opts['password']
  action [:create, :start]
end

execute 'change /logs/mysql dir permissions' do
  command 'chown -R mysql:mysql /logs/mysql'
  user 'root'
  action :run
end

if node['mysql_config']['instance_name'] == 'master'
  server_id = rand(1001..2000)
  server_id = server_id.to_i
else
  server_id = rand(2001..9999)
end

mysql_config node['mysql_config']['instance_name'] do
  instance node['mysql_config']['instance_name']
  source 'defaults.cnf.erb'
  variables(
    server_id: server_id
    )
  action :create
  notifies :restart, "mysql_service[#{node['mysql_config']['instance_name']}]", :immediately
end

execute 'remove old innodb log files' do
  command 'rm -f /data/mysql/ib_logfile*'
  user 'root'
  action :run
end
