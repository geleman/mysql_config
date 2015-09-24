require 'spec_helper'

describe file('/etc/iptables.d/mysql') do
  it { should be_file }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 3306 -j ACCEPT') }
end

describe file('/logs/mysql') do
  it { should be_directory }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe package('mysql-community-server') do
  it { should be_installed }
end

describe file('/etc/mysql-master/conf.d/master.cnf') do
  it { should be_file }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
  it { should be_mode 640 }
end

describe file('/data/mysql/ib_logfile*') do
  it { should_not exist }
end
