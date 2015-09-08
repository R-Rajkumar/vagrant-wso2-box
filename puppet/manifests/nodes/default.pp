# default (base) cartridge node
node /default/ inherits base {
  require java
  class { 'python_agent': }
  class { 'configurator': }
  Class['stratos_base'] -> Class['python_agent'] -> Class['configurator']
}
