#
# Cookbook Name:: mysql_config
# Recipe:: scheduler
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

execute 'change /data scheduler' do
  if node['mysql_config']['data']['disk'] == nil
    command "datamnt=`df -h /data | awk -F '/' '{ if (NR>1) {print $3}}' | awk '{print $1}'` | echo $datamnt | echo deadline > /sys/block/$datamnt/queue/scheduler | cat /sys/block/$datamnt/queue/scheduler"
  else
    command "echo deadline > /sys/block/sdb/queue/scheduler"  
    user 'root'
    action :run
  end  
end

execute 'change /logs scheduler' do
  if node['mysql_config']['log']['disk'] == nil
    command "logmnt=`df -h /logs | awk -F '/' '{ if (NR>1) {print $3}}' | awk '{print $1}'` | echo $logmnt | echo deadline > /sys/block/$logmnt/queue/scheduler | cat /sys/block/$logmnt/queue/scheduler"
  else
    command "echo deadline > /sys/block/sdc/queue/scheduler"  
    user 'root'
    action :run
  end  
end