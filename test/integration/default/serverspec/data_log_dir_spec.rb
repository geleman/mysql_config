require 'spec_helper'

describe command('mount | grep -i /data') do
  its(:exit_status) { should eq 0 }
end

describe file('/data/mysql') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe command('mount | grep -i /logs') do
  its(:exit_status) { should eq 0 }
end

describe file('/logs/mysql') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe file('/logs/mysql/bin-logs') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe file('/logs/mysql/relay-logs') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end
