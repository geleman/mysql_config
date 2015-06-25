#
# Cookbook Name:: mysql_config
# Recipe:: mysqldb
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


mysql_service 'test' do
	port '3306'
	version '5.6'
	data_dir '/data/mysql'
	tmp_dir '/tmp/shm'
	error_log '/logs/mysql/mysql.err'
	socket '/tmp/mysqld.sock'
	pid_file '/tmp/mysqld.pid'
	bind_address '0.0.0.0'
	initial_root_password 'change_me'
	action [:create, :start]
end


execute 'change binlogs dir permissions' do
	command 'chown -R mysql:mysql /logs/mysql/bin-logs'
    user 'root'
    action :run
end

execute 'change reloay logs dir permissions' do
	command 'chown -R mysql:mysql /logs/mysql/relay-logs'
    user 'root'
    action :run
end

mysql_config 'test' do
	instance 'test'
	source 'defaults.cnf.erb'
	action :create
	notifies :restart, 'mysql_service[test]'
end