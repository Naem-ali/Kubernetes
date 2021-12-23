#!/bin/bash

###### install first docker incase you don't have it installed #######

 echo "installing docker"
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
sleep 3

docker -version
docker ps 

#### now you can start installing kubernetes #####
### Requirement -> 2G memory, atleast 2 CPUs -> Linux: ubuntu: 20.4.1 LTS #####

echo "installing kubernetes_Kubeadm_Worker_node"
apt-get update
sudo apt install curl
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl

# you don't need to execute further commands on the working node!
# just ssh from your master to worker_node and execute the saved token in worker CLI. 
# your worker_node should be available after a while in a cluster, if it doesn't appear you can restart the kubelet!
