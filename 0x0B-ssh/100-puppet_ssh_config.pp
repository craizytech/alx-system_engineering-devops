# This file creates a ruby script to create a config file using puppet
file { '.ssh/config':
  ensure  => present,
  path    => '~/.ssh/config',
  mode    => '0744',
  owner   => cr,
  group   => cr,
  content => "
Host remote_server
  HostName 54.237.208.13
  User "ubuntu"
  IdentityFile ~/.ssh/school
  PasswordAuthentication no
"
}
