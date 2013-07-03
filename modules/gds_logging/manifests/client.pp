class gds_logging::client {
  class {'rsyslog':
    purge_rsyslog_d => true,
  }
  class {'rsyslog::client':
    server    => '172.16.10.12',
    port      => '5544',
    log_local => true,
  }
}
