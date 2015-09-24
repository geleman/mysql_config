require 'spec_helper'

describe command('/opt/chef/embedded/bin/gem list mysql2 | grep -i mysql2') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match("mysql2 (0.3.17)\n") }
end
