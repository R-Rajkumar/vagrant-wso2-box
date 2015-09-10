class wso2greg (
  $version            = undef,
  $owner              = 'root',
  $group              = 'root',
  $environment_params = undef,
)  {

  $service_code       = "wso2greg"
  $server_name        = "${service_code}-${version}"
  $target             = "/mnt/${server_ip}"
  $carbon_home        = "/mnt/${server_ip}/${server_name}"
  $configurator_home  = "/mnt/${configurator_name}-${configurator_version}"
  $template_module_pack = "${server_name}-template-module-${ppaas_version}.zip"
  $java_home  = "/opt/${java_folder}"

# adding more env params such as java home, carbon home to $environment_params array
  $environment__util_params = ["CARBON_HOME=${carbon_home}", "CONFIGURATOR_HOME=${configurator_home}"]
  $environment_params_to_configurator = split(inline_template("<%= (environment_params + environment__util_params).join(',') %>"),',')

# creating /mnt/{ip_address} folder
  exec {
    "creating_target_for_${server_name}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "mkdir -p ${target}";

    "creating_local_package_repo_for_${server_name}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      unless  => "test -d ${local_package_dir}",
      command => "mkdir -p ${local_package_dir}";
  }

# copy {server}.zip file to /mnt/packs folder
  file {
    "$local_package_dir/${server_name}.zip":
      ensure    => present,
      source    => ["puppet:///modules/${service_code}/packs/${server_name}.zip"],
      require   => Exec["creating_local_package_repo_for_${server_name}", "creating_target_for_${server_name}"];
  }

# unzipping {server}.zip file to /mnt/{ip_address} folder 
  exec {
    "extracting_${server_name}.zip_for_${server_name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      command   => "unzip ${local_package_dir}/${server_name}.zip",
      logoutput => 'on_failure',
      creates   => "${target}/${server_name}/repository",
      timeout   => 0,
      require   => File["$local_package_dir/${server_name}.zip"];

    "setting_permission_for_${server_name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      command   => "chown -R ${owner}:${owner} ${target}/${server_name} ;
                    chmod -R 755 ${target}/${server_name}",
      logoutput => 'on_failure',
      timeout   => 0,
      require   => Exec["extracting_${server_name}.zip_for_${server_name}"];
  }

# Copying template module
  file {
    "$local_package_dir/${template_module_pack}":
      ensure    => present,
      source    => ["puppet:///modules/${service_code}/packs/${template_module_pack}"],
      require   => Exec["setting_permission_for_${server_name}"];
  }

  exec {
    "extracting_template_module_${template_module_pack}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => "/mnt/${configurator_name }-${configurator_version}/template-modules",
      command   => "unzip -o ${local_package_dir}/${template_module_pack}",
      logoutput => 'on_failure',
      timeout   => 0,
      require   => File["$local_package_dir/${template_module_pack}"];
  }

# starting configurator
  exec { "starting_configurator":
    user        => $owner,
    environment => $environment_params_to_configurator,
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command     => "${configurator_home}/configurator.py",
    require   => Exec["extracting_template_module_${template_module_pack}"];
  }

# copy mysql.sql to /tmp/registry_mysql.sql
  file {
    "/tmp/registry_mysql.sql":
      ensure    => present,
      source    => ["puppet:///modules/${service_code}/dbscripts/registry/mysql.sql"],
  }

# create registry database
exec { "create-registry-db":
    unless => "/usr/bin/mysql -uroot -proot -e \"use mbie_registry;\"",
    command => "/usr/bin/mysql -uroot -proot -e \"create database mbie_registry; use mbie_registry; source /tmp/registry_mysql.sql; grant all on mbie_registry.* to 'root'@'%' identified by 'root';\"",
    require => [Service["mysql"], File["/tmp/registry_mysql.sql"]];
 }

# copy mysql.sql to /tmp/userdb_mysql.sql
  file {
    "/tmp/userdb_mysql.sql":
      ensure    => present,
      source    => ["puppet:///modules/${service_code}/dbscripts/userdb/mysql.sql"],
  }

# create user database
exec { "create-user-db":
    unless => "/usr/bin/mysql -uroot -proot -e \"use mbie_userdb;\"",
    command => "/usr/bin/mysql -uroot -proot -e \"create database mbie_userdb; use mbie_userdb; source /tmp/userdb_mysql.sql; grant all on mbie_userdb.* to 'root'@'%' identified by 'root';\"",
    require => [Service["mysql"], File["/tmp/userdb_mysql.sql"]];
 }


# copy mysql.sql to /tmp/apimgtdb_mysql.sql
  file {
    "/tmp/apimgtdb_mysql.sql":
      ensure    => present,
      source    => ["puppet:///modules/${service_code}/dbscripts/apimgt/mysql.sql"],
  }

# create apimgt database
exec { "create-apimgt-db":
    unless => "/usr/bin/mysql -uroot -proot -e \"use mbie_apimgtdb;\"",
    command => "/usr/bin/mysql -uroot -proot -e \"create database mbie_apimgtdb; use mbie_apimgtdb; source /tmp/apimgtdb_mysql.sql; grant all on mbie_apimgtdb.* to 'root'@'%' identified by 'root';\"",
    require => [Service["mysql"], File["/tmp/apimgtdb_mysql.sql"]];
 }

# start wso2 server
  exec { "strating_${name}":
    user    => $owner,
    environment => "JAVA_HOME=${java_home}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
    command => "touch ${carbon_home}/wso2carbon.lck; ${carbon_home}/bin/wso2server.sh restart > /dev/null 2>&1 &",
    creates => "${carbon_home}/repository/wso2carbon.log",
    require   => Exec["starting_configurator", "create-apimgt-db", "create-user-db", "create-registry-db"];
  }
}
