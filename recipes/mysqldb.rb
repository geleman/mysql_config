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
	socket '/tmp/mysqld.sock'
	pid_file '/tmp/mysqld.pid'
	initial_root_password 'change_me'
	action [:create, :start]
end


#execute "change data_dir permissions" do
#	command "chown -R mysql:mysql /data/mysql"
#	action :nothing
#end

#execute "change log_dir permissions" do
#	command "chown -R mysql:mysql /logs/mysql"
#	action :run
#end