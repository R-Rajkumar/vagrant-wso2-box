# WSO2 Dev Boxes
It is a tool to build your WSO2 dev environment in seconds!

# Technologies Used
  - Vagrant
  - Puppet
  - [WSO2 Private PaaS Configurator](https://github.com/wso2/product-private-paas/tree/master/components/org.wso2.ppaas.configurator)
  - [WSO2 Product Template Modules](https://github.com/wso2/product-private-paas/tree/master/cartridges/templates-modules)

# Supported WSO2 Products
  - [WSO2 ESB 4.9.0](http://wso2.com/products/enterprise-service-bus/)
  - [WSO2 ESB 4.8.1](http://wso2.com/products/enterprise-service-bus/)
  - [WSO2 Governance Registry 5.0.0](http://wso2.com/products/governance-registry/)
  - [WSO2 Governance Registry 4.6.0](http://wso2.com/products/governance-registry/)
  - [WSO2 API Manager 1.9.1](http://wso2.com/products/api-manager/)
  - [WSO2 API Manager 1.9.0](http://wso2.com/products/api-manager/)
  - [WSO2 Data Services Server 3.2.2](http://wso2.com/products/data-services-server/)

# How to use?
- Clone this project. 
```sh
$ git clone https://github.com/R-Rajkumar/vagrant-wso2-box.git
```

- Copy mysql connector to templates-modules/wso2esb-4.9.0/files/repository/components/lib. Likewise, You may need to copy it to all template modules. 
```sh
$ cp /home/rajkumar/softwares/mysql-connector-java-5.1.35-bin.jar templates-modules/wso2esb-4.9.0/files/repository/components/lib
```

- Build it with maven. When you build, it will copy all the template modules to relevant puppet modules. 
```sh
$ cd vagrant-wso2-box
$ mvn clean install
```
- Copy WSO2 Products packs to puppet modules. 
```sh
$ cp /home/rajkumar/softwares/wso2/esb/wso2esb-4.9.0.zip  puppet/modules/wso2esb/files/packs
```

- Run vagrant up to start a VM with WSO2 ESB. It will start only ESB. 
```sh
$ cd vagrant-wso2-box
$ vagrant up wso2esb
```

- If you want to start all the servers defined in servers.yaml, run this.
```sh
$ cd vagrant-wso2-box
$ vagrant up
```

- If you want to ssh into the ESB machine. 
```sh
$ cd vagrant-wso2-box
$ vagrant ssh wso2esb
```

- If you want to suspend the ESB machine. 
```sh
$ cd vagrant-wso2-box
$ vagrant suspend wso2esb
```

- If you want to resume a suspended ESB machine
```sh
$ cd vagrant-wso2-box
$ vagrant resume wso2esb
```

- If you want to provision ESB machine. It will trigger puppet provisioning again. So ESB will be restarted with applied changes. It is the way to apply patches. You need to copy patches to templated modules and provision the ESB machine with the following command. 
```sh
$ cd vagrant-wso2-box
$ vagrant provision wso2esb
```

- If you want to halt a ESB machine. 
```sh
$ cd vagrant-wso2-box
$ vagrant halt wso2esb
```

- If you want to destroy a ESB machine.
```sh
$ cd vagrant-wso2-box
$ vagrant destroy wso2esb
```
