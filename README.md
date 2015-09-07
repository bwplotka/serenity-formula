# Serenity-formulas
Salt formula and scripts for Mesos with Serenity deployment.
 
For the full Salt Formulas installation and usage see [instructions](http://docs.saltstack.com/topics/development/conventions/formulas.html).
 
For official Serenity page see [Project Serenity](https://github.com/mesosphere/serenity).

## Requirements
* Zookeper is working. TODO(bplotka): Point to proper tutorial - when using DCOS Zookeeper properly configured.
* Salt installed and configured on nodes.
* Proper DNS and hostname setup.
* Master and Slaves nodes must be able to communicate freely with each other.
* For marathon: java installed.

## Status

Tested on CentOS 7, 36x Intel Xeon E5 v3 machines with NFS storage under DCOS.

## Installation:
On salt master node:

1. Install formulas from this repo to `/srv/formulas/`:

        git clone https://github.com/Bplotka/serenity-formula.git
        
2. Add `/srv/formulas/serenity-formula` to `/etc/salt/master` conf under:
 
        file_roots:
          base:
            - /srv/formulas/serenity-formula

3. Copy `serenity.sls.example` to `/srv/pillar/serenity.sls` and edit file to configuration.
(make sure that `dns` , `zookeeper_cluster_size` and `master_lb` are filled properly.
4. Copy or append content from `top.sls.example` to `/srv/pillar/top.sls`
5. Set roles for each node using salt:

        $ salt 'masternode.example.com' grains.setval mesos-roles [master]
        $ salt 'agentnode.example.com' grains.setval mesos-roles [slave]

6. Set roles for each slave if needed:

        $ salt 'agentnode.example.com' grains.setval mesos-default-role custom_role
        
9. Run formula to prepare configuration:

        $ salt '*' state.sls serenity.setup
 
8. Configure your build system to put mesos build in `/srv/formulas/serenity/build/mesos_latest/`
9. Make sure that `/srv/formulas/serenity/build/` has write rights for your build system.

## Installation under DCOS:
These formulas are able to work also under the DCOS.

On salt master node:
Do all steps from above section except 5. Theses formulas will use dcos-roles.

## Usage:
1. Each time you deploy and build new mesos & serenity source you can deploy it easily:

        $ salt '*' state.sls serenity.deploy_all
     
2. Each time you deploy and build ONLY serenity source you can deploy it easily:

        $ salt '*' state.sls serenity.deploy
        
Or just deploy on slaves:

        $ salt -G 'dcos-roles:slave' state.sls serenity.deploy

Under the DCOS in case of need for reverting mesos to the DCOS version just run:
```
  $ salt '*' state.sls serenity.use_dcos
```

## Marathon installation and usage via serenity-formula:

Serenity formula is able to run configured marathon as well. As default it deploys proper marathon services to systemd in HA on the same nodes 
where _Mesos Masters_ are.
In case of willing to run custom marathon using this formula you need some additional steps to make it running: 

1. Make sure that you have java installed on your machine.
2. Download marathon.jar (version you want to have in your cluster)
3. Use `serenity.deploy_with_marathon` instead of `serenity.deploy_all`

        $ salt -G 'dcos-roles:slave' state.sls serenity.deploy_with_marathon


## Other information:

* Make sure that every needed file from mesos build is present (for now, `.so` , `./sbin` and `./share` are downloaded)