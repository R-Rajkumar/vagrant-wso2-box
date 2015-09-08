# API Manager cartridge node
node /wso2am/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

node /wso2api-pubstore/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0',
    config_param_profile            => 'PubStore',
    config_param_km_ip            => '192.168.100.50',
    config_param_km_https_proxy_port            => '9443',
    config_param_gw_ip            => '192.168.100.50',
    config_param_gw_https_proxy_port            => '9443',  
    config_param_gw_worker_ip            => '192.168.100.50',
    config_param_gw_worker_pt_http_proxy_port            => '8280',
    config_param_gw_worker_pt_https_proxy_port            => '8243',
    config_param_key_validator_client_type            => 'WSClient',
    config_param_enable_thrift_server            => 'false',
    config_param_clustering            => 'true',
    config_param_apimgt_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_apimgtdb',
    config_param_apimgt_db_username            => 'root',
    config_param_apimgt_db_password            => 'root',
    config_param_um_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_userdb',
    config_param_um_db_username            => 'root',
    config_param_um_db_password            => 'root',
    config_param_reg_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_registry',
    config_param_reg_db_username            => 'root',
    config_param_reg_db_password            => 'root',
    config_param_remote_registry_url            => 'https://192.168.100.10:9443'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

node /wso2api-gwkm/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0',
    config_param_profile            => 'GWKM',
    config_param_km_ip            => 'localhost',
    config_param_km_https_proxy_port            => '9443',
    config_param_gw_ip            => 'localhost',
    config_param_gw_https_proxy_port            => '9443',  
    config_param_gw_worker_ip            => 'localhost',
    config_param_gw_worker_pt_http_proxy_port            => '8280',
    config_param_gw_worker_pt_https_proxy_port            => '8243',
    config_param_key_validator_client_type            => 'WSClient',
    config_param_enable_thrift_server            => 'false',
    config_param_clustering            => 'true',
    config_param_apimgt_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_apimgtdb',
    config_param_apimgt_db_username            => 'root',
    config_param_apimgt_db_password            => 'root',
    config_param_um_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_userdb',
    config_param_um_db_username            => 'root',
    config_param_um_db_password            => 'root',
    config_param_reg_db_url            => 'jdbc:mysql://192.168.100.10:3306/mbie_registry',
    config_param_reg_db_username            => 'root',
    config_param_reg_db_password            => 'root',
    config_param_remote_registry_url            => 'https://192.168.100.10:9443'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

