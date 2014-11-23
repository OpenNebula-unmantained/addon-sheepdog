#!/bin/bash -e

PATCH_ARG=" " # --dry-run
CP_ARG="-uv"
ONEUSER="oneadmin"

if [ -z "$ONE_LOCATION" ]; then
    ONE_LOCAL_VAR=/var/lib/one
    ONE_LIB=/usr/lib/one
    DS_DIR=/var/lib/one/datastores
else
    ONE_LOCAL_VAR=$ONE_LOCATION/var
    ONE_LIB=$ONE_LOCATION/lib
    DS_DIR=$ONE_LOCATION/var/datastores
fi

#######################
### DONT EDIT BELOW ###
#######################

cd $( dirname $0 ) && SOURCE=$( pwd )

#
# tm/sheepdog
#
mkdir -pv $ONE_LOCAL_VAR/remotes/tm/sheepdog

for FILE in $SOURCE/src/tm_mad/sheepdog/*
do
    cp $CP_ARG $FILE $ONE_LOCAL_VAR/remotes/tm/sheepdog
done
chown -R $ONEUSER $ONE_LOCAL_VAR/remotes/tm/sheepdog
chmod u+x -R $ONE_LOCAL_VAR/remotes/tm/sheepdog

#
# datastore/sheepdog
#
mkdir -pv $ONE_LOCAL_VAR/remotes/datastore/sheepdog

for FILE in $SOURCE/src/datastore_mad/remotes/sheepdog/*
do
    cp $CP_ARG $FILE $ONE_LOCAL_VAR/remotes/datastore/sheepdog
done

chown -R $ONEUSER $ONE_LOCAL_VAR/remotes/datastore/sheepdog
chmod u+x -R $ONE_LOCAL_VAR/remotes/datastore/sheepdog

#
# edit oned.conf
#
grep -i sheepdog /etc/one/oned.conf || (

sed -i -r 's/(ceph,dev)/\1,sheepdog/g' /etc/one/oned.conf
cat >>/etc/one/oned.conf <<EOF
TM_MAD_CONF = [
 name = "sheepdog", ln_target = "NONE", clone_target = "SELF", shared = "yes"
]
EOF

)

#
# patch corefiles
#
cd $ONE_LIB/ruby/cli/one_helper
patch $PATCH_ARG < $SOURCE/patches/oneimage_helper.rb.patch

cd $ONE_LIB/ruby/opennebula
patch $PATCH_ARG < $SOURCE/patches/image.rb.patch

cd $ONE_LIB/sunstone/public/js/plugins
patch $PATCH_ARG < $SOURCE/patches/datastores-tab.js.patch

cd $ONE_LOCAL_VAR/remotes/vmm/kvm
patch $PATCH_ARG < $SOURCE/patches/attach_disk.patch

cd $ONE_LOCAL_VAR/remotes
patch $PATCH_ARG < $SOURCE/patches/scripts_common.sh.patch

cd $ONE_LIB/sh
patch $PATCH_ARG < $SOURCE/patches/scripts_common.sh.patch
