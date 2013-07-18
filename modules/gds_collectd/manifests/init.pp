# collectd installation
#
# collect metrics on cpu, memory and network
# log to syslog at 'info' level
# send data collected to graphite on the monitoring box
#
class gds_collectd {
  class { 'collectd':
    purge        => true,
    recurse      => true,
    purge_config => true,
  }

  class { 'collectd::plugin::write_graphite':
    graphitehost => '172.16.10.10',
  }

  collectd::plugin {'syslog':}
  collectd::plugin {'memory':}
  collectd::plugin {'cpu':}
  collectd::plugin {'interface':}
}
