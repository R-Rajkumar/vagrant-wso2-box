# ESB cartridge node
node /wso2esb/ inherits base {

  class { 'java': }
  class { 'configurator': }
  class { 'wso2esb':
    version      => '4.9.0-BETA'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator'] -> Class['wso2esb']
}


