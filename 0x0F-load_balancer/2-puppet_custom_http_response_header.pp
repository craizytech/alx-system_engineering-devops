# Add stable version of Nginx
exec { 'add_nginx_stable_repo':
  command => 'add-apt-repository -y ppa:nginx/stable',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  unless  => 'grep -q "nginx/stable" /etc/apt/sources.list /etc/apt/sources.list.d/*',
}

# Update software packages list
exec { 'update_packages':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['add_nginx_stable_repo'],
}

# Install Nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update_packages'],
}

# Allow HTTP through UFW
exec { 'allow_http':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  unless  => "ufw status | grep -q 'Nginx HTTP'",
}

# Set correct folder permissions
file { '/var/www/html':
  ensure  => directory,
  mode    => '0755',
  recurse => true,
}

# Create index file
file { '/var/www/html/index.html':
  content => "Hello World!\n",
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

# Create custom 404 error page
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page\n",
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

# Manage Nginx default config file
file { '/etc/nginx/sites-enabled/default':
  ensure  => file,
  content =>
"server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;
	index index.html;

	server_name _;

	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}

	add_header X-Served-By \$hostname;

	location / {
		try_files \$uri \$uri/ =404;
	}

	error_page 404 /404.html;

	location = /404.html {
		internal;
	}
}
",
  notify  => Service['nginx'],
}


# Start and enable Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}