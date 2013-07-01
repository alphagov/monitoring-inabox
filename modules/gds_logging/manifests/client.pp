class gds_logging::client {
  class {'rsyslog::client':
    server    => '172.16.10.12',
    log_local => true,
  }
}
