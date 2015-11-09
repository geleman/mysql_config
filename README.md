# MySQL Configuration Cookbook

This wrapper cookbook installs and configures MySQL Community while also optimizing the OS.
The attributes files is configured to be on a system with 4G of memory and uses separate disk for
data and logs for added performance and data integrity. This is intended to give a better out the box
install than a default rpm mysql install. You can fork this repo and edit the attributes files to take
better advantage of your system resources as well as add/subtract attributes.

The [MySQL Community Cookbook](https://github.com/chef-cookbooks/mysql) is the basis for the initial install.
You will use both the mysql_service and mysql_support resource. I suggest reading the [README](https://github.com/chef-cookbooks/mysql/blob/master/README.md) thoroughly before starting.

## Supported Platforms

RHEL Family

## Cookbook Dependencies

- 'mysql'
- 'lvm'
- 'selinux'
- 'sysctl'
- 'limits'
- 'iptables'
- 'mysql2_chef_gem'
- 'database'
- 'gdp-base-linux'

## Kitchen
```
When running kitchen you can speed up the process by adding the vagrant plugin vagrant-vbguest (0.10.0) and uncommenting:
- test/Files/vagrantAdditional.rb 
in the .kitchen.yml and .kitchen.ec2.yml files.

If you want to test using lvm then you will need to use lvm-1.4.0 from Chef Supermarket for Centos 6.7.
At that point you can uncomment scheduler in order to test changing the scheduler to something other than cfq
and uncommetn the attributes for [data][disk] and [log][disk]
You will at this poing need to uncomment commented out lines in scheduler_spec.rb and data_log_dir_spec.rb in /test/default/serverspec
```

## Attributes

**These attributes will be used in the mysql_support resource**
```
# MySQL Community Version 5.5, 5.6, or 5.7
node.default['mysql_support']['version'] = '5.6'
```
```
# Default mysql config attributes
node.default['mysql_support']['data_dir'] = '/data/mysql'
node.default['mysql_support']['tmp_dir'] = '/tmp/shm'
node.default['mysql_support']['error_log'] = '/logs/mysql/mysql.err'
node.default['mysql_support']['socket'] = '/tmp/mysqld.sock'
node.default['mysql_support']['pid_file'] = '/tmp/mysqld.pid'
node.default['mysql_support']['instance_name'] = 'master'
node.default['mysql_support']['user'] = 'mysql'
node.default['mysql_support']['port'] = '3306'
node.default['mysql_support']['max_allowed_packet'] = '64M'
node.default['mysql_support']['slow_query_log'] = 'off'
node.default['mysql_support']['binlog_format'] = 'ROW'
node.default['mysql_support']['expire_logs_days'] = '7'
node.default['mysql_support']['innodb_file_per_table'] = '1'
node.default['mysql_support']['innodb_buffer_pool_size'] = '2G'
node.default['mysql_support']['innodb_buffer_pool_instances'] = '4'
node.default['mysql_support']['innodb_log_files_in_group'] = '2'
node.default['mysql_support']['innodb_log_file_size'] = '128M'
node.default['mysql_support']['innodb_log_buffer_size'] = '48M'
node.default['mysql_support']['innodb_flush_log_at_trx_commit'] = '2'
node.default['mysql_support']['innodb_stats_on_metadata'] = 'OFF'
```
**Databag attributes**
```
node.default['mysql_support']['databag_name'] = 'master'
```
**Disk attributes use lvm if in vagrant, lvm is not used for scalr**
```
# disk attributes

node.default['mysql_support']['data']['disk'] = nil
node.default['mysql_support']['log']['disk'] =  nil
node.default['mysql_support']['data']['mount'] = '/data'
node.default['mysql_support']['log']['mount'] = '/logs'
```
**tmpfs attribute**
```
# tmpfs mount
node.default['mysql_support']['tmpfs'] = '/tmp/shm'
```
**Sysctl can be set to any number but 0 allows for full memory usage before swapping to disk**
```
# sysctl attribute
node.default['sysctl']['params']['vm']['swappiness'] = 0
```
**In vagrant you can set your ip's to whatever you would like before hand. scalr you will have to use a global variable
to get the master server ip before starting the build on slave servers**
```
# master_ip attribute
node.default['mysql_support']['master_ip'] = nil
```

## Databags

Use databags to create passwords for the mysql root user on both master and slave instances as well as for a replication user.

```json

{
  "id": "master",
  "password": "change_me"
}

{
  "id": "slave",
  "password": "slave_pass"
}

{
  "id": "replication",
  "password": "repl_2"
}
```

## Usage

### mysql_support

There are multiple uses for mysql_support. You can use it as standalone to do a single mysql server install or use role cookbooks
to bring up a master and multiple slaves and start replication.

### Sample runlist for standalone install with no replication

```json

{
  "run_list": [
    "recipe[gdp-base-linux]",
    "selinux::permissive",
    "sysctl::apply",
    "mysql_support::mysql_user",
    "mysql_support::limits",
    "mysql_support::datafiles",
    "mysql_support::logfiles",
    "mysql_support::tmpdir",
    "mysql_support::scheduler",
    "mysql_support::mysqldb",

  ]
}
```
### Sample default recipe in a master role cookbook

```
include_recipe 'gdp-base-linux'
include_recipe 'selinux::permissive'
include_recipe 'sysctl::apply'
include_recipe 'mysql_support::mysql_user'
include_recipe 'mysql_support::limits'
include_recipe 'mysql_support::datafiles'
include_recipe 'mysql_support::logfiles'
include_recipe 'mysql_support::tmpdir'
include_recipe 'mysql_support::scheduler'
include_recipe 'mysql_support::mysqldb'
include_recipe 'mysql_support::mysql2_gem'
include_recipe 'mysql_support::start_replication'
```
### Sample default recipe and attributes for slave cookbook

```
attributes to override mysql_support attributes 

node.normal['mysql_support']['instance_name'] = 'slave'
node.normal['mysql_support']['databag_name'] = 'slave'

default recipe is same as master role with only the attribute changes

include_recipe 'gdp-base-linux'
include_recipe 'selinux::permissive'
include_recipe 'sysctl::apply'
include_recipe 'mysql_support::mysql_user'
include_recipe 'mysql_support::limits'
include_recipe 'mysql_support::datafiles'
include_recipe 'mysql_support::logfiles'
include_recipe 'mysql_support::tmpdir'
include_recipe 'mysql_support::scheduler'
include_recipe 'mysql_support::mysqldb'
include_recipe 'mysql_support::mysql2_gem'
include_recipe 'mysql_support::start_replication'
```

## License and Authors

Author:: Greg Lane glane@gannett.com
