# API Manager cartridge node
node /wso2am-1.9.0/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

node /wso2api-pubstore-1.9.0/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0',
    environment_params =>  [
        "CONFIG_PARAM_PROFILE=PubStore",
        "CONFIG_PARAM_KEYMANAGER_IP=192.168.100.50",
        "CONFIG_PARAM_KEYMANAGER_HTTPS_PROXY_PORT=9443",
        "CONFIG_PARAM_GATEWAY_IP=192.168.100.50",
        "CONFIG_PARAM_GATEWAY_HTTPS_PROXY_PORT=9443",
        "CONFIG_PARAM_GATEWAY_WORKER_IP=192.168.100.50",
        "CONFIG_PARAM_GATEWAY_WORKER_PT_HTTP_PROXY_PORT=8280",
        "CONFIG_PARAM_GATEWAY_WORKER_PT_HTTPS_PROXY_PORT=8243",
        "CONFIG_PARAM_KEYVALIDATORCLIENTTYPE=WSClient",
        "CONFIG_PARAM_ENABLETHRIFTSERVER=false",
        "CONFIG_PARAM_CLUSTERING=false",
        "CONFIG_PARAM_APIMGT_DB_URL=jdbc:mysql://192.168.100.10:3306/apimgtdb",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_UM_DB_URL=jdbc:mysql://192.168.100.10:3306/userdb",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_REG_DB_URL=jdbc:mysql://192.168.100.10:3306/registry",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_REMOTE_REGISTRY_URL=https://192.168.100.10:9443",
        ]
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

node /wso2api-gwkm-1.9.0/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0',
    environment_params =>  [
        "CONFIG_PARAM_PROFILE=GatewayKeymanager",
        "CONFIG_PARAM_KEYVALIDATORCLIENTTYPE=WSClient",
        "CONFIG_PARAM_ENABLETHRIFTSERVER=false",
        "CONFIG_PARAM_CLUSTERING=false",
        "CONFIG_PARAM_APIMGT_DB_URL=jdbc:mysql://192.168.100.10:3306/apimgtdb",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_UM_DB_URL=jdbc:mysql://192.168.100.10:3306/userdb",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_REG_DB_URL=jdbc:mysql://192.168.100.10:3306/registry",
        "CONFIG_PARAM_DB_USER_NAME=root",
        "CONFIG_PARAM_DB_PASSWORD=root",
        "CONFIG_PARAM_REMOTE_REGISTRY_URL=https://192.168.100.10:9443",
        ]
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}

