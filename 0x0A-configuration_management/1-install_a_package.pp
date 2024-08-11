#This puppet manifest installs flask version 2.1.0

# ensure that pip ins installed
package { 'python3-pip':
  ensure => installed,
}

# ensure flask version 2.1.0 is installed via pip3
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip']
}
