# This file creates a ruby script to create a config file using puppet
file { '.ssh/config':
  ensure  => present,
  path    => '~/.ssh/config',
  mode    => '0744',
  owner   => cr,
  group   => cr,
  content => "
Host remote_server
  HostName 34.205.65.3
  User "ubuntu"
  IdentityFile ~/.ssh/school
  PasswordAuthentication no
"
}
