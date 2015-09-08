# API Manager cartridge node
node /wso2greg/ inherits base {

  class { 'java': }
  class { 'mysql': }
  class { 'configurator': }
  class { 'wso2greg':
    version      => '4.6.0'
  }
#Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['wso2greg']
  Class['stratos_base'] -> Class['mysql'] -> Class['java'] -> Class['configurator']-> Class['wso2greg']
}
