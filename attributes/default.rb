# MySQL Community Version 5.5, 5.6, or 5.7
node.default['mysql_config']['version'] = '5.6'

# Default mysql config attributes
node.default['mysql_config']['data_dir'] = '/data/mysql'
node.default['mysql_config']['tmp_dir'] = '/tmp/shm'
node.default['mysql_config']['error_log'] = '/logs/mysql/mysql.err'
node.default['mysql_config']['socket'] = '/tmp/mysqld.sock'
node.default['mysql_config']['pid_file'] = '/tmp/mysqld.pid'
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

# databag attribute
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
