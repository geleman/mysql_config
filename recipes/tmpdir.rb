#
# Cookbook Name:: mysql_support
# Recipe:: tmpdir
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

mount '/dev/shm' do
  device 'tmpfs'
  action [:umount, :disable]
end

directory node['mysql_support']['tmpfs'] do
  owner 'root'
  group 'root'
  mode  '0777'
  recursive true
  action :create
end

mount node['mysql_support']['tmpfs'] do
  device 'tmpfs'
  fstype 'tmpfs'
  options 'rw,size=1G,noatime'
  action [:mount, :enable]
end
