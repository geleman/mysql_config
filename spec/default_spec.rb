# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::mysqldb' do
  before do
    # Chef::Recipe.any_instance.stub(:data_bag).with('mysql').and_return(json)
    stub_data_bag('mysql').and_return(['password', 'mysql'])
    stub_data_bag_item('mysql', 'master').and_return({
      id: 'mysql',
      password: 'test'
    })
    stub_command("/usr/bin/test -f /data/mysql/mysql/user.frm").and_return(true)
  end
  #let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.6').converge(described_recipe) }
  cached(:mysql_config_test) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6',
      step_into: 'mysql_service'
    ) do |node|
      node.set['mysql']['version'] = '5.6',
      node.set['mysql_config']['instance_name'] = 'test',
      node.set['mysql_config']['databag_name'] = 'mysql'
    end.converge('mysql_config::mysqldb')
  end
  # before do
  #  stub_command("cat /etc/rc.local | grep 'never > /sys/kernel/mm/transparent_hugepage/enabled'").and_return(true)  
  #end

  context 'compling the test recipe' do
    it 'creates mysql_service[master]' do
      expect(mysql_config_test).to create_mysql_service('master')
    end
  end

  context 'stepping into mysql_service[master] resource' do
    it 'installs package mysql-community-server' do
      expect(mysql_config_test).to install_package('master :create mysql-community-server')
        .with(package_name: 'mysql-community-server', version: nil)
    end

    it 'stop service [master :create mysqld]' do
      expect(mysql_config_test).to disable_service('master :create mysqld')
      expect(mysql_config_test).to stop_service('master :create mysqld')
    end

    it 'creates group[master :create mysql]' do
      expect(mysql_config_test).to create_group('master :create mysql')
    end

    it 'creates user[master :create mysql]' do
      expect(mysql_config_test).to create_user('master :create mysql')
    end

    it 'changes permissions to /logs/mysql' do
      expect(mysql_config_test).to run_execute('chown -R mysql:mysql /logs/mysql')
    end

    it 'removes old innodb log files' do
      expect(mysql_config_test).to run_execute('rm -f /data/mysql/ib_logfile*')
    end

  end
end

describe 'mysql_config::datafiles' do
  before do
    # Chef::Recipe.any_instance.stub(:data_bag).with('mysql').and_return(json)
    stub_data_bag('mysql').and_return(['password', 'mysql'])
    stub_data_bag_item('mysql', 'master').and_return({
      id: 'mysql',
      password: 'test'
    })
    stub_command("/usr/bin/test -f /data/mysql/mysql/user.frm").and_return(true)
  end
   cached(:mysql_config_test) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6',
      step_into: 'mysql_service'
    ) do |node|
      node.set['mysql']['version'] = '5.6',
      node.set['mysql_config']['instance_name'] = 'test',
      node.set['mysql_config']['databag_name'] = 'mysql'
    end.converge('mysql_config::mysqldb')
  end

  it 'creates /data/mysql directory' do
    expect(mysql_config_test).to create_directory('/data/mysql')
  end
end
