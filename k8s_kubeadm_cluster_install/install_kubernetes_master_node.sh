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
echo "installing kubernetes_Kubeadm_cluster"
apt-get update
sudo apt install curl
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF  
apt-get install -y kubelet kubeadm kubectl
### create an actual cluster, you can change the pod network cidr ###
kubeadm init --pod-network-cidr=192.168.0.0/16 
# this will take some time and after that the following instructions will be on your screen, please save the token from the screen in a file 
# you will need it when adding nodes to the Master, starting with kubeadm join --token

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# now you have to install the CNI pluginfor the container communication, you can either choose flannel or calico, i am using flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# after this your kubernetes cluster Master should be ready

kubectl get cluster-info
kubectl get nodes