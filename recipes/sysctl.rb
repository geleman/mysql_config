#
# Cookbook Name:: mysql_support
# Recipe:: sysctl
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'sysctl::default'

sysctl_param 'vm.swappiness' do
  value 0
end
