# Installing a flask application from pip3 in a puppet
package { 'Flask':
  ensure => '2.1.0',
  provider => 'pip3'
}