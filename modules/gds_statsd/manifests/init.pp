# installs gstatsd and python
class gds_statsd {
  ensure_packages(['python-dev','python-pip'])
  Package [['python-dev'],['python-pip']] ->
  class {'gstatsd':
    graphite_server => '172.16.10.10',
    flush_interval  => 10,
  }
}
