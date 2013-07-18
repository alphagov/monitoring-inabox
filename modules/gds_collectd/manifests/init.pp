# collectd installation
#
# collect metrics on cpu, memory and network
# log to syslog at 'info' level
# send data collected to graphite on the monitoring box
#
class gds_collectd {
  include collectd
  include collectd::plugin::write_graphite

  collectd::plugin {'cpu':}
}
