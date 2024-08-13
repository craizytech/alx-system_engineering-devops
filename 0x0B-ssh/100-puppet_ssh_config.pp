# Ensure the ssh client uses the specified private key
file_line { 'Declare identity file':
    ensure => present,
    line   => ' IdentityFile ~/.ssh/school',
    path   => '/etc/ssh/ssh_config',
    match  => '^#?IdentityFile'
}

# Ensure password authentication is disabled
file_line { 'Turn off passwd auth':
    ensure => present,
    path   => '/etc/ssh/ssh_config',
    line   => '  PasswordAuthentication no',
    match  => '^#?PasswordAuthentication'
}