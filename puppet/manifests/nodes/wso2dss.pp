# ESB cartridge node
node /wso2dss/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2dss':
    version      => '3.2.2'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator'] -> Class['wso2dss']
}


