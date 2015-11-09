# require 'spec_helper'

# describe command('cat /sys/block/sdb/queue/scheduler | awk \'NR>1{print $1}\' RS=[ FS=] | grep -i deadline') do
#  its(:exit_status) { should eq 0 }
# end
