# MySQL Community Version 5.5, 5.6, or 5.7
node.default['mysql_support']['version'] = '5.6'

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

# databag attribute
node.default['mysql_support']['databag_name'] = 'master'

# disk attributes
node.default['mysql_support']['data']['disk'] = nil
node.default['mysql_support']['log']['disk'] = nil
node.default['mysql_support']['data']['mount'] = '/data'
node.default['mysql_support']['log']['mount'] = '/logs'

# tmpfs mount
node.default['mysql_support']['tmpfs'] = '/tmp/shm'

# sysctl attribute
node.default['sysctl']['params']['vm']['swappiness'] = 0

# master_ip attribute
node.default['mysql_support']['master_ip'] = nil
