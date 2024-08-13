# Installing and configuring nginx with puppet
package { 'nginx':
    ensure => installed,
}

# Ensure the index.html file exists with the content "Hello World!"
file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World',
    mode    => '0644'
}

# Ensure the Nginx service is running
service { 'nginx':
    ensure => running,
    enable => true,
}

# Nginx configuration file to handle redirection and root request
file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    # Serve 'Hello World!' at the root
    location / {
        root /var/www/html;
        index index.html
    }

    # Redirect /redirect_me to the root with a 301 moved permanently
    location /redirect_me {
        return 301 /;
    }
}
",
    notify  => Service['nginx'], # Notify the Nginx service to reload when this file changes
}

# Ensure the Nginx configuration is valid
exec { 'nginx -t':
    command => 'nginx -t',
    path    => ['/usr/bin', '/usr/sbin'],
    notify  => Service['nginx'] # Notify the Nginx service to reload if the config test passes
}