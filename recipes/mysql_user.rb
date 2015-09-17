#
# Cookbook Name:: mysql_config
# Recipe:: mysql_user
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

# System users
group "create mysql group" do
  group_name 'mysql'
  action :create
end

user "create mysql user" do
  username 'mysql'
  gid 'mysql'
  action :create
end
