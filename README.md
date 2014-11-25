# Sheepdog Storage Driver

## Description

The sheepdog datastore driver provides OpenNebula with the possibility of using sheepdog based block-devices for VM images instead of the default file form.

## Development

To contribute bug patches or new features, you can use the github Pull Request model. It is assumed that code and documentation are contributed under the Apache License 2.0.

More info:
* [How to Contribute](http://opennebula.org/addons/contribute/)
* Support: [OpenNebula user mailing list](http://opennebula.org/community:mailinglists)
* Development: [OpenNebula developers mailing list](http://opennebula.org/community:mailinglists)
* Issues Tracking: Github issues (https://github.com/OpenNebula/addon-sheepdog/issues)

## Authors

* Leader: Fabian Zimmermann (dev.faz@gmail.com)

## Compatibility

This add-on is compatible with a *patched version of OpenNebula 4.10*

https://github.com/OpenNebula/one/pull/40

## Requirements

### OpenNebula Front-end

Password-less ssh access to the sheepdog-nodes.

### Sheepdog Cluster

A working sheepdog cluster is required. (http://sheepdog.github.io/sheepdog/)

## Limitations

There are some limitations:

Libvirt based snapshots (Snapshots-tab in OpenNebula) are not working as expected.
A snapshot is created, but you will not be able to use OpenNebula or libvirt snapshot-revert to restore it automatically!

Workaround: Use Storage-Snapshots (Storage-tab in OpenNebula) to create a hot-copy as soon as your VM in suspend-to-disk.

## Installation

### OpenNebula Management

! Create a backup of your system !

* ssh to opennebula management system
* `cd /usr/src`
* `git clone https://github.com/OpenNebula/addon-sheepdog`
* `bash addon-sheepdog/install.sh`
* restart opennebula

### Sheepdog nodes

* oneadmin have to be able to execute "dog" as root without password

```bash
cat >/etc/sudoers.d/opennebula-sheepdog <<EOF
Cmnd_Alias ONE_SHEEPDOG = /usr/sbin/dog
oneadmin ALL=(ALL) NOPASSWD: ONE_SHEEPDOG
EOF
```

### Libvirt nodes

*  sheepdog-support in qemu required

`qemu-img | grep -o sheepdog && echo 'OK' || echo 'MISSING!'`

## Configuration

### Configuring sheepdog Datastores

* access your sunstone webgui
* create a new datastore
* select preset "sheepdog"
* click "create"
* select your new datastore
* add attribute
```
name: BRIDGE_LIST
value: a space seperated list of your sheepdog-nodes as value
```
