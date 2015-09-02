#
# Cookbook Name:: mysql_config
# Recipe:: limits
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

limits_config 'system limits' do
  limits [
    { domain: '*', type: 'hard', item: 'nofile', value: '65536' },
    { domain: '*', type: 'soft', item: 'nofile', value: '65536' },
    { domain: '*', type: 'hard', item: 'nproc', value: '65536' },
    { domain: '*', type: 'soft', item: 'nproc', value: '65536' }
  ]
  use_system true
end