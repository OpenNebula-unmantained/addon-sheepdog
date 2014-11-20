# Sheepdog Storage Driver

## Description

The sheepdog datastore driver provides OpenNebula with the possibility of using sheepdog based block-devices for VM images instead of the default file form. 

## Development

To contribute bug patches or new features, you can use the github Pull Request model. It is assumed that code and documentation are contributed under the Apache License 2.0. 

More info:
* [How to Contribute](http://opennebula.org/addons/contribute/)
* Support: [OpenNebula user mailing list](http://opennebula.org/community:mailinglists)
* Development: [OpenNebula developers mailing list](http://opennebula.org/community:mailinglists)
* Issues Tracking: Github issues (https://github.com/OpenNebula/addon-iscsi/issues)

## Authors

* Leader: Fabian Zimmermann (dev.faz@gmail.com)

## Compatibility

This add-on is compatible with OpenNebula 4.10.

## Requirements

### OpenNebula Front-end

Password-less ssh access to the nodes.

### Sheepdog Cluster

A working sheepdog cluster is required.

## Limitations

There are some limitations that you have to consider, though:

* No VM memory snapshots, because libvirt is currenlty not able to handle this.
* Snapshots of your disk/images are working.

## Installation

To install the driver you have to copy these files:

* `tm` -> `/var/lib/one/remotes/tm/sheepdog`
* `datastore` -> `/var/lib/one/remotes/datastore/sheepdog`

## Configuration

### Configuring the System Datastore

t.b.d.

### Configuring iSCSI Datastores

t.b.d.

### Host Configuration

* sheepdog have to be installed
* qemu also requires sheepdog-support to be enabled.

