# 100-puppet_ssh_config.pp

# Ensure the SSH client configuration file is present
file { '/home/vagrant/.ssh/config':
  ensure => file,
  mode   => '0600',
  owner  => 'vagrant',
  group  => 'vagrant',
}

# Configure the SSH client to use the private key ~/.ssh/school
file_line { 'Declare identity file':
  path   => '/home/vagrant/.ssh/config',
  line   => '    IdentityFile ~/.ssh/school',
  ensure => present,
}

# Configure the SSH client to refuse password authentication
file_line { 'Turn off passwd auth':
  path   => '/home/vagrant/.ssh/config',
  line   => '    PasswordAuthentication no',
  ensure => present,
}
