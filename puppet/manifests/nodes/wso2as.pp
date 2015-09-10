# AppServer cartridge node
node /[0-9]{1,12}.*wso2as/ inherits base {

  class { 'java': }
  class { 'python_agent':
    docroot => "/var/www"
  }
  class { 'configurator': }
  class { 'wso2as':
    version      => '5.2.1'
  }

  Class['stratos_base'] -> Class['java'] -> Class['configurator']-> Class['python_agent'] -> Class['wso2as']
}
