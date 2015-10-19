#
# Cookbook Name:: mysql_config
# Recipe:: datafiles_lvm
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lvm::default'

lvm_volume_group 'data' do
  physical_volumes [node['mysql_config']['data']['disk']]
  logical_volume 'datafiles' do
    group 'data'
    size '100%VG'
    filesystem 'ext4'
    mount_point location: node['mysql_config']['data']['mount'], options: 'noatime,data=ordered'
  end
end

directory "#{node['mysql_config']['data']['mount']}/mysql" do
  owner 'mysql'
  group 'mysql'
  mode '0750'
  recursive true
  action :create
end
