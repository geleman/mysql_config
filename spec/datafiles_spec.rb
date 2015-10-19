# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::datafiles' do
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
    let(:datafiles) do
      ChefSpec::SoloRunner.new do |node|
        node.set['mysql_config']['data']['disk'] = nil
        node.set['mysql_config']['data']['mount'] = '/data'
      end.converge('mysql_config::datafiles')
    end 

    it 'creates /data directory' do
      expect(datafiles).to create_directory('/data')
        .with(
          path: '/data',
          owner: 'mysql',
          group: 'mysql',
          mode: '0750',
          recursive: true
        )
    end

    it 'creates /data/mysql directory' do
      expect(datafiles).to create_directory('/data/mysql')
        .with(
          path: '/data/mysql',
          owner: 'mysql',
          group: 'mysql',
          mode: '0750',
          recursive: true
        )
    end
  end  
end