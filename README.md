# WSO2 Dev Boxes
It is a tool to build your WSO2 dev environment in seconds!

# Technologies Used
  - Vagrant
  - Puppet
  - WSO2 Private PaaS Configurator
  - WSO2 Product Template Modules

# How to use?
```sh
$ git clone https://github.com/R-Rajkumar/vagrant-wso2-box.git
$ cd vagrant-wso2-box
$ mvn clean install
$ cp /home/rajkumar/softwares/wso2/esb/wso2esb-4.9.0.zip  puppet/modules/wso2esb/files/packs
$ vagrant up wso2esb
$ vagrant ssh wso2esb
$ vagrant suspend wso2esb
$ vagrant resume wso2esb
$ vagrant provision wso2esb
$ vagrant halt wso2esb
$ vagrant destroy wso2esb
```
