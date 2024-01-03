# 7-puppet_install_nginx_web_server.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => 'running',
  enable => true,
}

# Configure Nginx main configuration file
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  source  => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Create the Hello World index file
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Configure Nginx site configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable the site by creating a symbolic link
file { '/etc/nginx/sites-enabled/default':
  ensure  => link,
  target  => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

# Create a custom redirect configuration for /redirect_me
file { '/etc/nginx/sites-available/redirect_me':
  ensure  => file,
  content => template('nginx/redirect_me.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable the redirect site by creating a symbolic link
file { '/etc/nginx/sites-enabled/redirect_me':
  ensure  => link,
  target  => '/etc/nginx/sites-available/redirect_me',
  require => File['/etc/nginx/sites-available/redirect_me'],
  notify  => Service['nginx'],
}

# Custom facts for Nginx
file { '/etc/facter/facts.d/nginx_facts.txt':
  ensure  => file,
  content => 'nginx_version=1.18.0',
}

# Notify Puppet to reload Nginx when configuration changes
exec { 'nginx-reload':
  command     => 'systemctl reload nginx',
  refreshonly => true,
  subscribe   => [
    File['/etc/nginx/nginx.conf'],
    File['/etc/nginx/sites-available/default'],
    File['/etc/nginx/sites-available/redirect_me'],
  ],
}

# End of Puppet manifest

