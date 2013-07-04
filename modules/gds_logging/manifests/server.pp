class gds_logging::server {
  package {'openjdk-7-jre':
    ensure => installed,
  }
  
  curl::fetch { 'logstash-flatjar':
    source      => 'https://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar',
    destination => '/var/tmp/logstash-1.1.13-flatjar.jar',
  }

  class {'logstash':
    provider    => 'custom',
    jarfile     => 'file:///var/tmp/logstash-1.1.13-flatjar.jar',
    require     => [Curl::Fetch['logstash-flatjar'],Package['openjdk-7-jre']],
  }

  logstash::input::tcp {'syslog':
    type => 'syslog',
    port => '5544',
  }
  logstash::input::udp {'syslog':
    type => 'syslog',
    port => '5544',
  }
  logstash::filter::grok {'syslog':
    type      => 'syslog',
    pattern   => [ '<%{POSINT:syslog_pri}>%{TIMESTAMP_ISO8601:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{PROG:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}' ],
    add_field => {
      'received_at'   => '%{@timestamp}',
      'received_from' => '%{@source_host}'
    },
    order     => '11',
  }
  logstash::filter::syslog_pri {'syslog':
    type  => 'syslog',
    order => '12',
  }
  logstash::filter::date {'syslog':
    type  => 'syslog',
    match => [ 'syslog_timestamp', 'MMM dd HH:mm:ss',
                'MMM  d HH:mm:ss' ],
    order => '13',
  }
  logstash::filter::mutate {'syslog-1':
    type         => 'syslog',
    order        => '14',
    exclude_tags => [ '_grokparsefailure' ],
    replace      => {
      '@source_host' => '%{syslog_hostname}',
      '@message'     => '%{syslog_message}'
    },
  }
  logstash::filter::mutate {'syslog-2':
    type   => 'syslog',
    order  => '15',
    remove => [ 'syslog_hostname', 'syslog_message', 'syslog_timestamp' ],
  }
  logstash::output::file {'test-file-output':
    type => 'syslog',
    path => '/var/log/logstash/all.log',
  }
  logstash::output::elasticsearch_http {'es':
    host  => '172.16.10.15',
    index => 'logs-current',
  }
}
