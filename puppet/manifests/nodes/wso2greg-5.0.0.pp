# API Manager cartridge node
node /wso2greg-5.0.0/ inherits base {

  class { 'java': }
  class { 'mysql': }
  class { 'configurator': }
  class { 'wso2greg':
    version      => '5.0.0',
    environment_params =>  [
	"CONFIG_PARAM_CLUSTERING=false",
	"CONFIG_PARAM_LOCAL_REGISTRY_DB_URL=jdbc:mysql://localhost:3306/registry?autoReconnect=true",
	"CONFIG_PARAM_LOCAL_REGISTRY_DB_USER_NAME=root",
	"CONFIG_PARAM_LOCAL_REGISTRY_DB_PASSWORD=root",
	"CONFIG_PARAM_USER_MGT_DB_URL=jdbc:mysql://localhost:3306/userdb",
	"CONFIG_PARAM_USER_MGT_DB_USER_NAME=root",
	"CONFIG_PARAM_USER_MGT_DB_PASSWORD=root",
	"CONFIG_PARAM_DRIVER_CLASS_NAME=com.mysql.jdbc.Driver"
        ]
  }
  Class['stratos_base'] -> Class['mysql'] -> Class['java'] -> Class['configurator']-> Class['wso2greg']
}
