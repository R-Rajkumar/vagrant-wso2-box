class configurator (

  $target             = "/mnt",
  $configurator_home  = "/mnt/${configurator_name}-${configurator_version}"
)
{

  $packages = ['python-dev', 'python-pip']

  package { $packages:
    ensure   => latest,
    provider => 'apt',
  }

  exec {
    "pip installs-jinja2":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "pip install jinja2",
  }

  exec {
    "creating_local_package_repo_for_${configurator_name}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      unless  => "test -d ${local_package_dir}",
      command => "mkdir -p ${local_package_dir}";
  }

  file { "${local_package_dir}/${configurator_name}-${configurator_version}.zip":
    ensure    => present,
    source    => "puppet:///modules/configurator/${configurator_name}-${configurator_version}.zip",
    owner     => "root",
    mode      => "0755",
    require   => Exec["creating_local_package_repo_for_${configurator_name}"];
  }

  file { "/etc/profile.d/configurator_home.sh":
    content => "export CONFIGURATOR_HOME=${configurator_home}",
    mode    => 755
  }

  exec {
    "extracting_${configurator_name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      command   => "unzip -o ${local_package_dir}/${configurator_name}-${configurator_version}.zip",
      logoutput => 'on_failure',
      creates   => "${target}/${configurator_name}-${configurator_version}",
      unless    => "test -d ${target}/${configurator}/configurator.py",
      require   => File["${local_package_dir}/${configurator_name}-${configurator_version}.zip"];
  }
}
