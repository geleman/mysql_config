require 'spec_helper'

describe command('/usr/bin/mysql -uroot -pchange_me -S /tmp/mysqld.sock -e "use mysql;select user from user;" | grep repl') do
  its(:exit_status) { should eq 0 }
end
