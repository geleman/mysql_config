# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::datafiles_lvm' do
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

  let(:lvm) do
    ChefSpec::SoloRunner.new do |node|
      node.set['mysql_config']['data']['disk'] = '/dev/sdb'
      node.set['mysql_config']['data']['mount'] = '/data'
    end.converge('mysql_config::datafiles_lvm')
  end 

  it 'includes lvm recipe' do
    expect(lvm).to include_recipe('mysql_config::datafiles_lvm')
  end

  it 'creates lvm group data' do
    expect(lvm).to create_lvm_volume_group('data')
  end

  it 'creates mysql directory in /data' do
    expect(lvm).to create_directory('/data/mysql')
      .with(
        path: '/data/mysql',
        owner: 'mysql',
        group: 'mysql',
        mode: '0750',
        recursive: true
      )
  end
end
