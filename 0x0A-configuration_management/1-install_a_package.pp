# Installing a flask application from pip3 in a puppet
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3'
}
