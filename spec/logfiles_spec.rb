# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::logfiles' do
  before do
    stub_command("/usr/sbin/httpd -t").and_return(true)
    stub_command("which sudo").and_return(true)
    stub_data_bag_item('users', 'fhanson').and_return({ id: "fhanson", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'rgindes').and_return({ id: "rgindes", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jneves').and_return({ id: "jneves", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jcrawford').and_return({ id: "jcrawford", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'blieberman').and_return({ id: "blieberman", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'akemner').and_return({ id: "akemner", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'rabdill').and_return({ id: "rabdill", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'nessus').and_return({ id: "nessus", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
  end
   
  context 'centos' do
    let(:logfiles) do
      ChefSpec::SoloRunner.new do |node|
        node.set['mysql_config']['log']['disk'] = nil
        node.set['mysql_config']['log']['mount'] = '/logs'
      end.converge('mysql_config::logfiles')
    end 

    it 'creates /logs directory' do
      expect(logfiles).to create_directory('/logs')
        .with(
          path: '/logs',
          owner: 'root',
          group: 'root',
          mode: '0755',
          recursive: true
        )
    end    

    it 'it creates /logs/mysql directory' do
      expect(logfiles).to create_directory('/logs/mysql')
        .with(
          path: '/logs/mysql',
          owner: 'root',
          group: 'root',
          mode: '0755',
          recursive: true
        )
    end
    
    it 'it creates /logs/mysql/bin-logs directory' do
      expect(logfiles).to create_directory('/logs/mysql/bin-logs')
        .with(
          path: '/logs/mysql/bin-logs',
          owner: 'root',
          group: 'root',
          mode: '0755',
          recursive: true
        )
    end

        it 'it creates /logs/mysql/relay-logs directory' do
      expect(logfiles).to create_directory('/logs/mysql/relay-logs')
        .with(
          path: '/logs/mysql/relay-logs',
          owner: 'root',
          group: 'root',
          mode: '0755',
          recursive: true
        )
    end
  end  
end