class gds_kibana {
  ensure_packages(['nginx-full'])

  # Kibana 3 isn't "release ready" yet, so currently you have to download a master snapshot tarball.
  # you probably want to package this.
  curl::fetch {'kibana-three':
    source      => 'https://codeload.github.com/elasticsearch/kibana/tar.gz/master',
    destination => '/var/tmp/kibana.tar.gz',
  }
  exec {'untar kibana':
    creates => '/var/www/kibana',
    command => '/bin/tar zxvf /var/tmp/kibana.tar.gz -C /usr/share/nginx/html',
    require => Curl::Fetch['kibana-three'],
  }
  file {'/usr/share/nginx/html/kibana-master/config.js':
    source  => 'puppet:///modules/gds_kibana/config.js',
    require => Exec['untar kibana'],
  }
}
