# This file creates a file school and sets its permissions
file {'/tmp/school':
	path => '/tmp/school',
	ensure => present,
	owner => 'www-data',
	group => 'www-data',
	mode => '0744',
	content => 'I love Puppet'
}
