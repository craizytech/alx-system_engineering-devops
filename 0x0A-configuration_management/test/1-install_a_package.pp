# installing flask version 2.1.0 on a puppet server
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3'
}
