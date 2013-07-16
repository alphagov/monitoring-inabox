# checks for sensu on client machines
class gds_sensu::client {
  include sensu

  sensu::check { 'check_file_exists':
    command     => 'test -e /tmp/missingfile',
    handlers    => 'default',
    subscribers => 'sensu-test',
  }
}
