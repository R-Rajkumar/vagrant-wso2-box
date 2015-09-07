# default (base) cartridge node
node /default/ inherits base {
  require java
  class { 'configurator': }
  Class['stratos_base'] -> Class['configurator']
}
