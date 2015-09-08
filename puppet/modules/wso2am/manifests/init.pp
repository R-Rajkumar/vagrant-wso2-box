class wso2am (
  $version            = undef,
  $owner              = 'root',
  $group              = 'root',
  $config_param_profile            = undef,
  $config_param_km_ip            = undef,
  $config_param_km_https_proxy_port            = undef,
  $config_param_gw_ip            = undef,
  $config_param_gw_https_proxy_port            = undef,  
  $config_param_gw_worker_ip            = undef,
  $config_param_gw_worker_pt_http_proxy_port            = undef,
  $config_param_gw_worker_pt_https_proxy_port            = undef,
  $config_param_key_validator_client_type            = undef,
  $config_param_enable_thrift_server            = undef,
  $config_param_clustering            = undef,
  $config_param_apimgt_db_url            = undef,
  $config_param_apimgt_db_username            = undef,
  $config_param_apimgt_db_password            = undef,
  $config_param_um_db_url            = undef,
  $config_param_um_db_username            = undef,
  $config_param_um_db_password            = undef,
  $config_param_reg_db_url            = undef,
  $config_param_reg_db_username            = undef,
  $config_param_reg_db_password            = undef,
  $config_param_remote_registry_url            = undef,
)  {

  $service_code       = "wso2am"
  $server_name        = "${service_code}-${version}"
  $target             = "/mnt/${server_ip}"
  $carbon_home        = "/mnt/${server_ip}/${server_name}"
  $configurator_home  = "/mnt/${configurator_name}-${configurator_version}"
  $template_module_pack = "${server_name}-template-module-${ppaas_version}.zip"
  $pca_home = "/mnt/${pca_name}-${pca_version}"
  $java_home  = "/opt/${java_folder}"

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
      require   => Exec["creating_local_package_repo_for_${server_name}"];
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
    environment => [ 
        "CARBON_HOME=${carbon_home}",
        "CONFIGURATOR_HOME=${configurator_home}",
        "JAVA_HOME=${java_home}",
        "CONFIG_PARAM_PROFILE=${config_param_profile}",
        "CONFIG_PARAM_KEYMANAGER_IP=${config_param_km_ip}",
        "CONFIG_PARAM_KEYMANAGER_HTTPS_PROXY_PORT=${config_param_km_https_proxy_port}",
        "CONFIG_PARAM_GATEWAY_IP=${config_param_gw_ip}",
        "CONFIG_PARAM_GATEWAY_HTTPS_PROXY_PORT=${config_param_gw_https_proxy_port}",
        "CONFIG_PARAM_GATEWAY_WORKER_IP=${config_param_gw_worker_ip}",
        "CONFIG_PARAM_GATEWAY_WORKER_PT_HTTP_PROXY_PORT=${config_param_gw_worker_pt_http_proxy_port}",
        "CONFIG_PARAM_GATEWAY_WORKER_PT_HTTPS_PROXY_PORT=${config_param_gw_worker_pt_https_proxy_port}",
        "CONFIG_PARAM_KEYVALIDATORCLIENTTYPE=${config_param_key_validator_client_type}",
        "CONFIG_PARAM_ENABLETHRIFTSERVER=${config_param_enable_thrift_server}",
        "CONFIG_PARAM_CLUSTERING=${config_param_clustering}",
        "CONFIG_PARAM_APIMGT_DB_URL=${config_param_apimgt_db_url}",
        "CONFIG_PARAM_DB_USER_NAME=${config_param_apimgt_db_username}",
        "CONFIG_PARAM_DB_PASSWORD=${config_param_apimgt_db_password}",
        "CONFIG_PARAM_UM_DB_URL=${config_param_um_db_url}",
        "CONFIG_PARAM_DB_USER_NAME=${config_param_um_db_username}",
        "CONFIG_PARAM_DB_PASSWORD=${config_param_um_db_password}",
        "CONFIG_PARAM_REG_DB_URL=${config_param_reg_db_url}",
        "CONFIG_PARAM_DB_USER_NAME=${config_param_reg_db_username}",
        "CONFIG_PARAM_DB_PASSWORD=${config_param_reg_db_password}",
        "CONFIG_PARAM_REMOTE_REGISTRY_URL=${config_param_remote_registry_url}",
	],
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command     => "${configurator_home}/configurator.py",
    require   => Exec["extracting_template_module_${template_module_pack}"];
  }

# start wso2 server
  exec { "strating_${name}":
    user    => $owner,
    environment => "JAVA_HOME=${java_home}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
    unless  => "test -f ${carbon_home}/wso2carbon.lck",
    command => "touch ${carbon_home}/wso2carbon.lck; ${carbon_home}/bin/wso2server.sh > /dev/null 2>&1 &",
    creates => "${carbon_home}/repository/wso2carbon.log",
    require   => Exec["starting_configurator"];
  }
}
