# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::limits' do
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

  subject do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6',
      step_into: 'limits_config'
    ) do |node|
      allow(node).to receive(:name).and_return('limits-test-node')
    end.converge('mysql_config::limits')
  end
 
  it 'creates a new systems file limits' do
    is_expected.to create_limits_config('system limits')
      .with(
        use_system: true,
        limits: [
          { domain: '*', type: 'hard', item: 'nofile', value: '65536' },
          { domain: '*', type: 'soft', item: 'nofile', value: '65536' },
          { domain: '*', type: 'hard', item: 'nproc', value: '65536' },
          { domain: '*', type: 'soft', item: 'nproc', value: '65536' }
        ]
      )
  end 

  it { is_expected.not_to create_directory('conf directory for system') }

  it do
    is_expected.to create_template('/etc/security/limits.conf')
      .with(
        cookbook: 'limits',
        source: 'limits.d.conf.erb',
        owner: 'root',
        group: 'root',
        mode: 0644
      )
  end
end