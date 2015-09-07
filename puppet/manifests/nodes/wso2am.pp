# API Manager cartridge node
node /wso2am/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2am':
    version      => '1.9.0'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2am']
}
