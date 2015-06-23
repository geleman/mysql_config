include_recipe 'lvm::default'

lvm_volume_group 'logs' do 
	physical_volumes ['/dev/sdc']
	logical_volume 'logfiles' do
		group 'logs'
		size '100%VG'
		filesystem 'ext4'
		mount_point location: '/logs', options: 'noatime,data=ordered'
	end	
end


directory '/logs/mysql' do
          owner 'mysql'
          group 'mysql'
          mode '0750'
          recursive true
          action :create
        end