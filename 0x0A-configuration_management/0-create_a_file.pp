# This file creates a file school and sets its permissions
file {'/tmp/school':
    ensure  => present,
    path    => '/tmp/school',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0744',
    content => 'I love Puppet'
}
