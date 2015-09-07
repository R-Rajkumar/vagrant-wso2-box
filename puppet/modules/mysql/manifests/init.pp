class mysql{

  if $stratos_mysql_password {
    $root_password = $stratos_mysql_password
  }
  else {
    $root_password = 'root'
  }

  package { ['mysql-server']:
    ensure => installed,
  }

  service { 'mysql':
    ensure  => running,
    pattern => 'mysql',
    require => Package['mysql-server'],
  }

  exec { 'Set root password':
    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    unless  => "mysqladmin -uroot -p${root_password} status",
    command => "mysqladmin -uroot password ${root_password}",
    require => Service['mysql'];
  }

  file { '/etc/mysql/my.cnf':
    ensure  => present,
    content => template('mysql/my.cnf.erb'),
    notify  => Service['mysql'],
    require => [
      Package['mysql-server']      
    ];
  }
}
