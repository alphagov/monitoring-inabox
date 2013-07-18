# sets up our package sources and updates
class gds_apt {
  include 'apt'
  apt::source {'gds-ppa':
    location   => 'http://ppa.launchpad.net/gds/govuk/ubuntu',
    repos      => 'main',
    key        => '914D5813',
    key_server => 'pgp.mit.edu',
  }
  Exec['apt_update'] -> Package <| |>
}
