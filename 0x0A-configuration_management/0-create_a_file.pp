file { '/tmp/school':
  ensure  => present,
  path    => '/tmp/school',
  content => 'I love Puppet',
  group   => www-data,
  owner   => www-data,
  mode    => '0744'
}
