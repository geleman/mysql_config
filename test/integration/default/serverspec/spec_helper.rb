require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$PATH'
