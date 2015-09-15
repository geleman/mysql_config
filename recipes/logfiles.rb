#
# Cookbook Name:: mysql_config
# Recipe:: logfiles
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

if !node['mysql_config']['log']['disk'].nil? && File.exist?(node['mysql_config']['log']['disk'])
  case node['platform']
  when 'redhat', 'centos', 'amazon', 'scientific'
    include_recipe 'mysql_config::logfiles_lvm'
  end
else
  directory node['mysql_config']['log']['mount'] do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

directory '/logs/mysql' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

directory '/logs/mysql/bin-logs' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

directory '/logs/mysql/relay-logs' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end
