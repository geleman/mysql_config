#
# Cookbook Name:: mysql_config
# Recipe:: datafiles
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

if !node['mysql_config']['data']['disk'].nil? && File.exist?(node['mysql_config']['data']['disk'])
  case node['platform']
  when 'redhat', 'centos', 'amazon', 'scientific'
    include_recipe 'mysql_config::datafiles_lvm'
  end
else
  directory node['mysql_config']['data']['mount'] do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

directory '/data/mysql' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end
