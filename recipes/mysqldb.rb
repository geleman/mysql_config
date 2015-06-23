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
	error_log '/logs/mysql/mysql.err'
	socket '/tmp/mysqld.sock'
	initial_root_password 'change_me'
	action [:create, :start]
end

mount '/dev/shm' do
	device 'tmpfs'
	action [:umount, :disable]
end

directory '/tmp/shm' do
	owner 'root'
	group 'root'
	mode  '0755'
	recursive true
	action :create
end

mount '/tmp/shm' do
	device 'tmpfs'
	fstype 'tmpfs'
	options 'rw,size=1G,noatime'
	action [:mount, :enable]
end