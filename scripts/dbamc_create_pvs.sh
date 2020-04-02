#!/bin/bash
# creating PV directories on Bastion host to map EFS volumes

if (sudo mkdir -p /data/ecm/cpe/cfgstore/) ; then
  echo "Created /data/ecm/cpe/cfgstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/cfgstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/filestore/) ; then
  echo "Created /data/ecm/cpe/filestore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/filestore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/bootstrapstore/) ; then
  echo "Created /data/ecm/cpe/bootstrapstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/bootstrapstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/fnlogstore/) ; then
  echo "Created /data/ecm/cpe/fnlogstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/fnlogstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/icmrulesstore/) ; then
  echo "Created /data/ecm/cpe/icmrulesstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/icmrulesstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/logstore/) ; then
  echo "Created /data/ecm/cpe/logstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/logstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/cpe/textextstore/) ; then
  echo "Created /data/ecm/cpe/textextstore/ successfully"
else
  echo "Unable to create /data/ecm/cpe/textextstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/cfgstore/) ; then
  echo "Created /data/ecm/icn/cfgstore/ successfully"
else
  echo "Unable to create /data/ecm/icn/cfgstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/logstore/) ; then
  echo "Created /data/ecm/icn/logstore/ successfully"
else
  echo "Unable to create /data/ecm/icn/logstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/pluginstore/) ; then
  echo "Created /data/ecm/icn/pluginstore/ successfully"
else
  echo "Unable to create /data/ecm/icn/pluginstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/vwcachestore/) ; then
  echo "Created /data/ecm/icn/vwcachestore/ successfully"
else
  echo "Unable to create /data/ecm/icn/vwcachestore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/vwlogstore/) ; then
  echo "Created /data/ecm/icn/vwlogstore/ successfully"
else
  echo "Unable to create /data/ecm/icn/vwlogstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/icn/asperastore/) ; then
  echo "Created /data/ecm/icn/asperastore/ successfully"
else
  echo "Unable to create /data/ecm/icn/asperastore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/cfgstore/) ; then
  echo "Created /data/ecm/css/cfgstore/ successfully"
else
  echo "Unable to create /data/ecm/css/cfgstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/indexstore/) ; then
  echo "Created /data/ecm/css/indexstore/ successfully"
else
  echo "Unable to create /data/ecm/css/indexstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/logstore/) ; then
  echo "Created /data/ecm/css/logstore/ successfully"
else
  echo "Unable to create /data/ecm/css/logstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/tempstore/) ; then
  echo "Created /data/ecm/css/tempstore/ successfully"
else
  echo "Unable to create /data/ecm/css/tempstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/customstore/) ; then
  echo "Created /data/ecm/css/customstore/ successfully"
else
  echo "Unable to create /data/ecm/css/customstore/"
  exit 1
fi

if (sudo mkdir -p /data/ecm/css/customstore/) ; then
  echo "Created /data/ecm/css/customstore/ successfully"
else
  echo "Unable to create /data/ecm/css/customstore/"
  exit 1
fi

runuser -l ec2-user -c "kubectl config set-context aws --namespace=fncm"

### CPE PVCs ###
# Mounting cpe-cfgstore-pvc
cpecfgstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-cfgstore-pvc -o jsonpath="{.spec.volumeName}"")
cpecfgstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpecfgstore_pv -o jsonpath="{.spec.nfs.path}"")
cpecfgstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpecfgstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpecfgstore_pv_server":"$cpecfgstore_pv_path /data/ecm/cpe/cfgstore
echo "Finished mounting cpe-cfgstore-pvc"

# Mounting cpe-filestore-pvc
cpefilestore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-filestore-pvc -o jsonpath="{.spec.volumeName}"")
cpefilestore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpefilestore_pv -o jsonpath="{.spec.nfs.path}"")
cpefilestore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpefilestore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpefilestore_pv_server":"$cpefilestore_pv_path /data/ecm/cpe/filestore
echo "Finished mounting cpe-filestore-pvc"

# Mounting cpe-bootstrapstore-pvc
cpebootstrapstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-bootstrapstore-pvc -o jsonpath="{.spec.volumeName}"")
cpebootstrapstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpebootstrapstore_pv -o jsonpath="{.spec.nfs.path}"")
cpebootstrapstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpebootstrapstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpebootstrapstore_pv_server":"$cpebootstrapstore_pv_path /data/ecm/cpe/bootstrapstore
echo "Finished mounting cpe-bootstrapstore-pvc"

# Mounting cpe-fnlogstore-pvc
cpefnlogstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-fnlogstore-pvc -o jsonpath="{.spec.volumeName}"")
cpefnlogstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpefnlogstore_pv -o jsonpath="{.spec.nfs.path}"")
cpefnlogstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpefnlogstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpefnlogstore_pv_server":"$cpefnlogstore_pv_path /data/ecm/cpe/fnlogstore
echo "Finished mounting cpe-fnlogstore-pvc"

# Mounting cpe-icmrulesstore-pvc
cpeicmrulesstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-icmrulesstore-pvc -o jsonpath="{.spec.volumeName}"")
cpeicmrulesstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpeicmrulesstore_pv -o jsonpath="{.spec.nfs.path}"")
cpeicmrulesstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpeicmrulesstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpeicmrulesstore_pv_server":"$cpeicmrulesstore_pv_path /data/ecm/cpe/icmrulesstore
echo "Finished mounting cpe-icmrulesstore-pvc"

# Mounting cpe-logstore-pvc
cpelogstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-logstore-pvc -o jsonpath="{.spec.volumeName}"")
cpelogstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpelogstore_pv -o jsonpath="{.spec.nfs.path}"")
cpelogstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpelogstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpelogstore_pv_server":"$cpelogstore_pv_path /data/ecm/cpe/logstore
echo "Finished mounting cpe-logstore-pvc"

# Mounting cpe-textextstore-pvc
cpetextextstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cpe-textextstore-pvc -o jsonpath="{.spec.volumeName}"")
cpetextextstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cpetextextstore_pv -o jsonpath="{.spec.nfs.path}"")
cpetextextstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cpetextextstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cpetextextstore_pv_server":"$cpetextextstore_pv_path /data/ecm/cpe/textextstore
echo "Finished mounting cpe-textextstore-pvc"


### CSS PVCs ###
# Mounting csscfgstore-pvc
csscfgstore_pv=$(runuser -l ec2-user -c "kubectl get pvc csscfgstore-pvc -o jsonpath="{.spec.volumeName}"")
csscfgstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $csscfgstore_pv -o jsonpath="{.spec.nfs.path}"")
csscfgstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $csscfgstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $csscfgstore_pv_server":"$csscfgstore_pv_path /data/ecm/css/cfgstore
echo "Finished mounting csscfgstore-pvc"

# Mounting for csscustomstore-pvc
csscustomstore_pv=$(runuser -l ec2-user -c "kubectl get pvc csscustomstore-pvc -o jsonpath="{.spec.volumeName}"")
csscustomstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $csscustomstore_pv -o jsonpath="{.spec.nfs.path}"")
csscustomstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $csscustomstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $csscustomstore_pv_server":"$csscustomstore_pv_path /data/ecm/css/customstore
echo "Finished mounting csscustomstore-pvc"

# Mounting for cssindexstore-pvc
cssindexstore_pv=$(runuser -l ec2-user -c "kubectl get pvc cssindexstore-pvc -o jsonpath="{.spec.volumeName}"")
cssindexstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $cssindexstore_pv -o jsonpath="{.spec.nfs.path}"")
cssindexstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $cssindexstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $cssindexstore_pv_server":"$cssindexstore_pv_path /data/ecm/css/indexstore
echo "Finished mounting cssindexstore-pvc"

# Mounting for csslogstore-pvc
csslogstore_pv=$(runuser -l ec2-user -c "kubectl get pvc csslogstore-pvc -o jsonpath="{.spec.volumeName}"")
csslogstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $csslogstore_pv -o jsonpath="{.spec.nfs.path}"")
csslogstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $csslogstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $csslogstore_pv_server":"$csslogstore_pv_path /data/ecm/css/logstore
echo "Finished mounting csslogstore-pvc"

# Mounting for csstempstore-pvc
csstempstore_pv=$(runuser -l ec2-user -c "kubectl get pvc csstempstore-pvc -o jsonpath="{.spec.volumeName}"")
csstempstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $csstempstore_pv -o jsonpath="{.spec.nfs.path}"")
csstempstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $csstempstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $csstempstore_pv_server":"$csstempstore_pv_path /data/ecm/css/tempstore
echo "Finished mounting csstempstore-pvc"


### ICN PVCs ###
# Mounting icn-cfgstore-pvc
icncfgstore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-cfgstore-pvc -o jsonpath="{.spec.volumeName}"")
icncfgstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icncfgstore_pv -o jsonpath="{.spec.nfs.path}"")
icncfgstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icncfgstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icncfgstore_pv_server":"$icncfgstore_pv_path /data/ecm/icn/cfgstore/
echo "Finished mounting icn-cfgstore-pvc"

# Mounting icn-logstore-pvc
icnlogstore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-logstore-pvc -o jsonpath="{.spec.volumeName}"")
icnlogstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icnlogstore_pv -o jsonpath="{.spec.nfs.path}"")
icnlogstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icnlogstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icnlogstore_pv_server":"$icnlogstore_pv_path /data/ecm/icn/logstore/
echo "Finished mounting icn-logstore-pvc"

# Mounting icn-pluginstore-pvc
icnpluginstore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-pluginstore-pvc -o jsonpath="{.spec.volumeName}"")
icnpluginstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icnpluginstore_pv -o jsonpath="{.spec.nfs.path}"")
icnpluginstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icnpluginstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icnpluginstore_pv_server":"$icnpluginstore_pv_path /data/ecm/icn/pluginstore/
echo "Finished mounting icn-pluginstore-pvc"

# Mounting icn-vw-cachestore-pvc
icnvwcachestore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-vw-cachestore-pvc -o jsonpath="{.spec.volumeName}"")
icnvwcachestore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icnvwcachestore_pv -o jsonpath="{.spec.nfs.path}"")
icnvwcachestore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icnvwcachestore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icnvwcachestore_pv_server":"$icnvwcachestore_pv_path /data/ecm/icn/vwcachestore/
echo "Finished mounting icn-vw-cachestore-pvc"

# Mounting icn-vw-logstore-pvc
icnvwlogstore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-vw-logstore-pvc -o jsonpath="{.spec.volumeName}"")
icnvwlogstore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icnvwlogstore_pv -o jsonpath="{.spec.nfs.path}"")
icnvwlogstore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icnvwlogstore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icnvwlogstore_pv_server":"$icnvwlogstore_pv_path /data/ecm/icn/vwlogstore/
echo "Finished mounting icn-vw-logstore-pvc"

# Mounting icn-asperastore-pvc
icnasperastore_pv=$(runuser -l ec2-user -c "kubectl get pvc icn-asperastore-pvc -o jsonpath="{.spec.volumeName}"")
icnasperastore_pv_path=$(runuser -l ec2-user -c "kubectl get pv $icnasperastore_pv -o jsonpath="{.spec.nfs.path}"")
icnasperastore_pv_server=$(runuser -l ec2-user -c "kubectl get pv $icnasperastore_pv -o jsonpath="{.spec.nfs.server}"")

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $icnasperastore_pv_server":"$icnasperastore_pv_path /data/ecm/icn/asperastore/
echo "Finished mounting icn-asperastore-pvc"