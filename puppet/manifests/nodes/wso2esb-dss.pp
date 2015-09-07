# ESB cartridge node
node /wso2esb-dss/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2esb':
    version      => '4.9.0-BETA'
  }
  class { 'wso2dss':
    version      => '3.2.2'
  }
  Class['stratos_base'] -> Class['java'] -> Class['configurator'] -> Class['wso2esb'] -> Class['wso2dss']
}


