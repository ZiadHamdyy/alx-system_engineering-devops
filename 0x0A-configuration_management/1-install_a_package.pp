# 1-install_a_package.pp

package { 'Werkzeug':
  ensure   => '2.0.2',
  provider => 'pip3',
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
