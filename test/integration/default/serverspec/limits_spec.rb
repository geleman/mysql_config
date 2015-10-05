require 'spec_helper'

describe command('ulimit -Hn | grep 65536') do
  its(:exit_status) { should eq 0 }
end

describe command('ulimit -Sn | grep 65536') do
  its(:exit_status) { should eq 0 }
end