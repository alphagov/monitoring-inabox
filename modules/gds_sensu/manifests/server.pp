class gds_sensu::server {
  include sensu, redis, rabbitmq::server

  Class['redis'] -> Class['sensu']
  Class['rabbitmq::server'] -> Class['sensu']

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
}
