class gds_apt::impl {
  class{'apt':
    stage => 'setup',
  }
  apt::source {'gds-ppa':
    location   => 'http://ppa.launchpad.net/gds/govuk/ubuntu',
    repos      => 'main',
    key        => '914D5813',
    key_server => 'pgp.mit.edu',
  }

}

class gds_apt {
  stage {'setup':
    before => Stage[main],
  }
  class {'gds_apt::impl':
    stage => 'setup',
  }
}
