# Using Puppet to make changes to our configuration file.

$cont = 'Host *
        IdentityFile ~/.ssh/school
        PasswordAuthentication no
	'

file { 'Change-file':
  ensure  => 'file',
  path    => '/etc/ssh/ssh_config',
  content => $cont,
}
