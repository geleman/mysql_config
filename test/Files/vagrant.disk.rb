VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider 'virtualbox' do |vb|
    unless File.exist?('master_1')
      vb.customize ['createhd',  '--filename', 'master_1.vdi', '--size', 8192]
      vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', '1', '--device', 0, '--type', 'hdd', '--medium', 'master_1.vdi']
    end
    unless File.exist?('master_2')
      vb.customize ['createhd', '--filename', 'master_2.vdi', '--size', 8192]
      vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', '1', '--device', 1, '--type', 'hdd', '--medium', 'master_2.vdi']
    end
  end
end
