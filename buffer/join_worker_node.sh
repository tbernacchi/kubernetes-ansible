#!/bin/bash
WORKERS=
IP=`hostname -I | awk '{ print $2 }'`

check_worker_list() {
if [ -z "$WORKERS" ];then
	echo "The list of hosts from master it's empty adding this one $IP..."
	join_cluster
else
	add_worker
fi
}

join_cluster() {
        kubeadm join 172.31.23.114:6443 --token xnvk9v.xe8yv74p6aa6rztf     --discovery-token-ca-cert-hash sha256:766aa3b8e1489db28c8f235c7d034d03ce2c50a2711935a6ca22d7509c07b160 
}

add_worker() {
for i in `echo $WORKERS`;do
        if [ "$i" == "$IP" ];then
                echo "The host $IP it's already in to the cluster, exiting..."
		exit 0 
        fi
done
join_cluster 
}
check_worker_list 
