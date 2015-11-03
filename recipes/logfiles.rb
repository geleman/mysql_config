#
# Cookbook Name:: mysql_support
# Recipe:: logfiles
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

if !node['mysql_support']['log']['disk'].nil? && File.exist?(node['mysql_support']['log']['disk'])
  case node['platform']
  when 'redhat', 'centos', 'amazon', 'scientific'
    include_recipe 'mysql_support::logfiles_lvm'
  end
else
  directory node['mysql_support']['log']['mount'] do
    owner 'mysql'
    group 'mysql'
    mode '0750'
    recursive true
    action :create
  end
end

directory "#{node['mysql_support']['log']['mount']}/mysql" do
  owner 'mysql'
  group 'mysql'
  mode '0750'
  recursive true
  action :create
end

['bin-logs', 'relay-logs'].each do |dir|
  directory "#{node['mysql_support']['log']['mount']}/mysql/#{dir}" do
    owner 'mysql'
    group 'mysql'
    mode '0750'
    recursive true
    action :create
  end
end

# directory '/logs/mysql' do
#  owner 'mysql'
#  group 'mysql'
#  mode '0750'
#  recursive true
#  action :create
# end

# directory '/logs/mysql/bin-logs' do
#  owner 'mysql'
#  group 'mysql'
#  mode '0750'
#  recursive true
#  action :create
# end

# directory '/logs/mysql/relay-logs' do
#  owner 'mysql'
#  group 'mysql'
#  mode '0750'
#  recursive true
#  action :create
# end
