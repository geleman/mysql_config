# Default mysql config attributes
node.normal['mysql_config']['instance_name'] = 'master'
node.normal['mysql_config']['user'] = 'mysql'
node.normal['mysql_config']['port'] = '3306'
node.normal['mysql_config']['max_allowed_packet'] = '64M'
node.normal['mysql_config']['slow_query_log'] = 'off'
node.normal['mysql_config']['binlog_format'] = 'ROW'
node.normal['mysql_config']['expire_logs_days'] = '7'
node.normal['mysql_config']['innodb_file_per_table'] = '1'
node.normal['mysql_config']['innodb_buffer_pool_size'] = '2G'
node.normal['mysql_config']['innodb_buffer_pool_instances'] = '4'
node.normal['mysql_config']['innodb_log_files_in_group'] = '2'
node.normal['mysql_config']['innodb_log_file_size'] = '128M'
node.normal['mysql_config']['innodb_log_buffer_size'] = '48M'
node.normal['mysql_config']['innodb_flush_log_at_trx_commit'] = '2'
node.normal['mysql_config']['innodb_stats_on_metadata'] = 'OFF'
node.normal['mysql_config']['databag_name'] = 'master'
node.normal['mysql_config']['databag_repl'] = 'replication'

# disk attributes
node.normal['mysql_config']['data']['disk'] = '/dev/sdb'
node.normal['mysql_config']['data']['mount'] = '/data'
node.normal['mysql_config']['log']['disk'] =  '/dev/sdc'
node.normal['mysql_config']['log']['mount'] = '/logs'

# sysctl attribute
node.normal['sysctl']['params']['vm']['swappiness'] = 0

# master_ip attribute
node.normal['mysql_config']['master_ip'] = '10.84.101.100'

