# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')

  sensu::check { 'check_file_exists':
    command     => 'test -e /tmp/missingfile',
    handlers    => 'default',
    subscribers => 'sensu-test',
  }
}

node 'sensu.internal' inherits default {

  rabbitmq_vhost { '/sensu':
    ensure   => present,
    provider => 'rabbitmqctl',
  }

  rabbitmq_user { 'sensu':
    admin    => true,
    password => 'secret',
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    provider             => 'rabbitmqctl',
  }

  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }

  Class['redis'] -> Class['sensu']
  Class['rabbitmq::server'] -> Class['sensu']

}
