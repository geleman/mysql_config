# MySQL Configuration Cookbook

This wrapper cookbook installs and configures MySQL Community while also optimizing the OS.
The attributes files is configured to be on a system with 4G of memory and uses separate disk for
data and logs for added performance and data integrity. This is intended to give a better out the box
install than a default rpm mysql install. You can fork this repo and edit the attributes files to take
better advantage of your system resources as well as add/subtract attributes.

The [MySQL Community Cookbook](https://github.com/chef-cookbooks/mysql) is the basis for the initial install.
You will use both the mysql_service and mysql_config resource. I suggest reading the [README](https://github.com/chef-cookbooks/mysql/blob/master/README.md) thoroughly before starting.

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

## Attributes

```
# Default mysql config attributes
node.default['mysql_config']['instance_name'] = 'master'
node.default['mysql_config']['user'] = 'mysql'
node.default['mysql_config']['port'] = '3306'
node.default['mysql_config']['max_allowed_packet'] = '64M'
node.default['mysql_config']['slow_query_log'] = 'off'
node.default['mysql_config']['binlog_format'] = 'ROW'
node.default['mysql_config']['expire_logs_days'] = '7'
node.default['mysql_config']['innodb_file_per_table'] = '1'
node.default['mysql_config']['innodb_buffer_pool_size'] = '2G'
node.default['mysql_config']['innodb_buffer_pool_instances'] = '4'
node.default['mysql_config']['innodb_log_files_in_group'] = '2'
node.default['mysql_config']['innodb_log_file_size'] = '128M'
node.default['mysql_config']['innodb_log_buffer_size'] = '48M'
node.default['mysql_config']['innodb_flush_log_at_trx_commit'] = '2'
node.default['mysql_config']['innodb_stats_on_metadata'] = 'OFF'
node.default['mysql_config']['databag_name'] = 'master'

# disk attributes
# vagrant settings
node.default['mysql_config']['data']['disk'] = '/dev/sdb'
node.default['mysql_config']['log']['disk'] =  '/dev/sdc'
# solr settings
# node.default['mysql_config']['data']['disk'] = nil
# node.default['mysql_config']['log']['disk'] =  nil
# solr & vagrant setttings
node.default['mysql_config']['data']['mount'] = '/data'
node.default['mysql_config']['log']['mount'] = '/logs'

# sysctl attribute
node.default['sysctl']['params']['vm']['swappiness'] = 0

# master_ip attribute
node.default['mysql_config']['master_ip'] = '10.84.101.100'
```

## Usage

### mysql_config::default

Include `mysql_config` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mysql_config::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
