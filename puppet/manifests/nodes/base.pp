# base node
node 'base' {

# General Configurations
  $ppaas_version        = '1.0.0-SNAPSHOT'
  $server_ip            = $ipaddress

# PCA Configurations
  $pca_name             = 'apache-stratos-python-cartridge-agent'
  $pca_version          = '4.1.0'
  $local_package_dir    = '/mnt/packs'
  $mb_ip                = 'localhost'
  $mb_port              = '1883'
  $cep_ip               = "localhost"
  $cep_port             = "7711"
  $cep_username         = 'admin'
  $cep_password         = 'admin'
  $bam_ip               = 'localhost'
  $bam_port             = '7611'
  $bam_secure_port      = '7711'
  $bam_username         = 'admin'
  $bam_password         = 'admin'
  $truststore_password  = 'wso2carbon'
  $enable_log_publisher = 'false'
  $metadata_service_url = 'https://192.168.30.96:9443'
  $agent_log_level      = "INFO"

# JAVA Configurations
  $java_distribution    = 'jdk-7u79-linux-x64.tar.gz'
  $java_folder          = 'jdk1.7.0_79'

# Configurator Configurations
  $configurator_name    = 'ppaas-configurator'
  $configurator_version = '4.1.0-SNAPSHOT'

  require stratos_base
}
