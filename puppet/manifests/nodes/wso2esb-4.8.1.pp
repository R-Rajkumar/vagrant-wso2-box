# ESB cartridge node
node /wso2esb-4.8.1/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2esb':
    version      => '4.8.1',
    environment_params =>  [
        "CONFIG_PARAM_CLUSTERING=false",
	"CONFIG_PARAM_REGISTRY_DB_URL=jdbc:mysql://192.168.100.10:3306/registry?autoReconnect=true",
	"CONFIG_PARAM_REGISTRY_DB_USER_NAME=root",
	"CONFIG_PARAM_REGISTRY_DB_PASSWORD=root",
	"CONFIG_PARAM_USER_MGT_DB_URL=jdbc:mysql://192.168.100.10:3306/_userdb",
	"CONFIG_PARAM_USER_MGT_DB_USER_NAME=root",
	"CONFIG_PARAM_USER_MGT_DB_PASSWORD=root",
	"CONFIG_PARAM_DRIVER_CLASS_NAME=com.mysql.jdbc.Driver"
        ]
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator'] -> Class['wso2esb']
}


