# ESB cartridge node
node /wso2dss/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2dss':
    version      => '3.2.2',
    environment_params =>  [
        "CONFIG_PARAM_CLUSTERING=false",
        "CONFIG_PARAM_REG_DB_URL=jdbc:mysql://192.168.100.10:3306/registry",
        "CONFIG_PARAM_REG_DB_USER_NAME=root",
        "CONFIG_PARAM_REG_DB_PASSWORD=root",
        "CONFIG_PARAM_USER_MGT_DB_URL=jdbc:mysql://192.168.100.10:3306/userdb",
        "CONFIG_PARAM_USER_MGT_DB_USER_NAME=root",
        "CONFIG_PARAM_USER_MGT_DB_PASSWORD=root",
	"CONFIG_PARAM_CONFIG_DB_URL=jdbc:mysql://192.168.100.10:3306/registry",
        "CONFIG_PARAM_CONFIG_DB_USER_NAME=root",
        "CONFIG_PARAM_CONFIG_DB_PASSWORD=root",
        "CONFIG_PARAM_DRIVER_CLASS_NAME=com.mysql.jdbc.Driver"
        ]
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator'] -> Class['wso2dss']
}


