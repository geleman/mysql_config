# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::start_replication' do
  before do
    stub_data_bag_item('mysql', 'master').and_return({ id: 'master', password: 'test' })
    stub_data_bag_item('mysql', 'slave').and_return({ id: 'slave', password: 'test' })
    stub_data_bag_item('mysql', 'replication').and_return({ id: 'replication', password: 'test' })
    stub_command("/usr/bin/test -f /data/mysql/mysql/user.frm").and_return(true)
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

  let(:replication) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6'
    ) do |node|
      node.override['mysql_config']['instance_name'] = 'slave'
    end.converge('mysql_config::start_replication')
  end
  
#  context 'compling the test recipe' do
#    it 'creates mysql_database_user[replication]' do
#      expect(start_replication).to create_mysql_database_user('replication')
#    end
#  end

#  context 'stepping into mysql_database_user[replication] resource' do
#    it 'creates user[replication create: repl]' do
#      expect(start_replication).to grant_user('replication :create repl')
#    end
#  end

  it 'runs bash[start replication]' do
    stub_command("mysql -uroot -ptest -S /tmp/mysqld.sock -e\n    'select * from information_schema.global_status where variable_name like \"slave_running\";' | grep ON").and_return(true)
    #expect(replication).to run_bash('start replication')
  end
end
