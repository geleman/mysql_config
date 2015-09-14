# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mysql_config::tmpdir' do
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

  let(:tmpdir) { ChefSpec::SoloRunner.converge('mysql_config::tmpdir') }

  it 'umounts /dev/shm directory' do
    expect(tmpdir).to umount_mount('/dev/shm')
  end

  it 'creates /tmp/shm directory' do
    expect(tmpdir).to create_directory('/tmp/shm')
      .with(
        path: '/tmp/shm',
        owner: 'root',
        group: 'root',
        mode: '0777',
        recursive: true
     )
  end
  
  it 'mounts /tmp/shm directory' do
    expect(tmpdir).to mount_mount('/tmp/shm')
  end
end
