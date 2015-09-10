# IS cartridge node
node /[0-9]{1,12}.*wso2is/ inherits base {

  class { 'java': }
  class { 'python_agent':
    docroot => "/var/www"
  }
  class { 'configurator': }
  class { 'wso2is':
    version      => '5.0.0'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['python_agent'] -> Class['wso2is']
}



