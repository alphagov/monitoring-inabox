class apt {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update || true',
  }
  Exec['apt-get update'] -> Package <| provider != pip and provider != gem and ensure != absent and ensure != purged |>
}
