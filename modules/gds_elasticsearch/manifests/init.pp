class gds_elasticsearch {
  ensure_packages(['openjdk-7-jre'])

  class { 'elasticsearch':
    version              => '0.20.6-ppa1~precise1',
    host                 => $::fqdn,
    require              => Package['openjdk-7-jre'],
    number_of_replicas   => 0,
  }

  elasticsearch::plugin { 'head':
    install_from => 'mobz/elasticsearch-head',
  }
}
