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

# we are getting a werkzeug error so we have to add the compatible
# werkzeug version for flask 2.10
package { 'werkzeug':
  ensure => '2.0.3',
  provider => 'pip3',
  require => Package['flask']
}
