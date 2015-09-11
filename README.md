# WSO2 Dev Boxes
It is a tool to build your WSO2 dev environment in seconds!

# Technologies Used
  - Vagrant
  - Puppet
  - WSO2 Private PaaS Configurator
  - WSO2 Product Template Modules

# Supported WSO2 Products
  - WSO2 ESB 4.9.0
  - WSO2 ESB 4.8.1
  - WSO2 Governance Registry 5.0.0
  - WSO2 Governance Registry 4.6.0
  - WSO2 API Manager 1.9.1
  - WSO2 API Manager 1.9.0
  - WSO2 Data Services Server 3.2.2

# How to use?
```sh
$ git clone https://github.com/R-Rajkumar/vagrant-wso2-box.git
$ cd vagrant-wso2-box
$ mvn clean install
$ cp /home/rajkumar/softwares/wso2/esb/wso2esb-4.9.0.zip  puppet/modules/wso2esb/files/packs
$ cp /home/rajkumar/softwares/mysql-connector-java-5.1.35-bin.jar templates-modules/wso2esb-4.9.0/files/repository/components/lib
$ vagrant up wso2esb
$ vagrant ssh wso2esb
$ vagrant suspend wso2esb
$ vagrant resume wso2esb
$ vagrant provision wso2esb
$ vagrant halt wso2esb
$ vagrant destroy wso2esb
```
