# Install Nginx package
package { 'nginx':
  ensure => present,
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  replace => true,
  content => "# Nginx default site configuration\n
              server {\n
                listen 80 default_server;\n
                listen [::]:80 default_server;\n\n
                root /var/www/html;\n
                index index.html index.htm index.nginx-debian.html;\n\n
                server_name _;\n\n
                location / {\n
                  try_files $uri $uri/ =404;\n
                }\n\n
                location /redirect_me {\n
                  return 301 http://$host/;\n
                }\n
              }",
  notify => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}

# Create Hello World index.html file
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}
