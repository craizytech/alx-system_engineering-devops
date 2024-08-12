# This puppet makes changes to the client configuration file

# Install openssh-client that includes the ssh-keygen
package { 'openssh-client':
    ensure => installed
}

# Generate the ssh key-pair using ssh-keygen
exec { 'generate_ssh_key':
    command => 'ssh-keygen -t rsa -b 4096 -f /home/ubuntu/.ssh/school -N "betty"',
    creates => '/home/ubuntu/.ssh/school',
    require => Package['openssh-client'],
    user    => 'ubuntu'
}

# Ensure the .ssh directory exists
file { '/home/ubuntu/.ssh':
    ensure => directory,
    owner  => 'ubuntu',
    group  => 'ubuntu',
    mode   => '0700',
}

# create and modify the config file
file { '/home/ubuntu/.ssh/config':
    ensure  => file,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    mode    => '0600',
    content => 'Host remote_server
    HostName 100.24.72.103
    User ubuntu
    IdentityFile /home/ubuntu/.ssh/school
    PasswordAuthentication no'
}