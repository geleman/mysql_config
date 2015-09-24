require 'spec_helper'

describe command('mount | grep -i /dev/shm') do
  its(:exit_status) { should eq 1 }
end

describe file('/tmp/shm') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('mount | grep -i /tmp/shm') do
  its(:exit_status) { should eq 0 }
end
