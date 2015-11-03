#
# Cookbook Name:: mysql_support
# Recipe:: mysqldb
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

opts = data_bag_item('mysql', node['mysql_support']['databag_name'])
include_recipe 'iptables'

iptables_rule 'mysql' do
  source 'mysql_3306'
end

mysql_service node['mysql_support']['instance_name'] do
  port node['mysql_support']['port']
  version node['mysql_support']['version']
  data_dir node['mysql_support']['data_dir']
  tmp_dir node['mysql_support']['tmp_dir']
  error_log node['mysql_support']['error_log']
  socket node['mysql_support']['socket']
  pid_file node['mysql_support']['pid_file']
  bind_address '0.0.0.0'
  initial_root_password opts['password']
  action [:create, :start]
end

execute 'change log dir permissions' do
  command "chown -R mysql:mysql #{node['mysql_support']['log']['mount']}/mysql"
  user 'root'
  action :run
end

if node['mysql_support']['instance_name'] == 'master'
  server_id = rand(1001..2000)
  server_id = server_id.to_i
else
  server_id = rand(2001..9999)
end

mysql_config node['mysql_support']['instance_name'] do
  instance node['mysql_support']['instance_name']
  source 'defaults.cnf.erb'
  variables(
    server_id: server_id
    )
  action :create
  notifies :restart, "mysql_service[#{node['mysql_support']['instance_name']}]", :immediately
end

execute 'remove old innodb log files' do
  command "rm -f #{node['mysql_support']['data']['mount']}/mysql/ib_logfile*"
  user 'root'
  action :run
end
