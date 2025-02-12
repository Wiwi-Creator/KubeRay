# 開 AKS Cluster
sh AKS_cluster/cluster_init.sh
# Install KubeRay via Helm
helm install kuberay-operator kuberay/kuberay-operator --version 1.2.2

# Install Nvidia-GPU-operator via Helm
helm install gpu-operator nvidia/gpu-operator -n gpu-operator --create-namespace --version=v24.9.1

# 建立 CPU Node Pool
#az aks nodepool add \
#  --resource-group AKS-resource-group \
#  --cluster-name AA-standard \
#  --name t4pool \
#  --mode User \
#  --os-sku Ubuntu \
#  --kubernetes-version 1.30.7 \
#  --node-vm-size Standard_NC4as_T4_v3 \
#  --enable-cluster-autoscaler \
#  --min-count 1 \
#  --max-count 5 \
#  --max-pods 30

# 建立 GPU Node Pool
az aks nodepool add \
  --resource-group AKS-resource-group \
  --cluster-name AA-standard \
  --name t4pool \
  --mode User \
  --os-sku Ubuntu \
  --kubernetes-version 1.30.7 \
  --node-vm-size Standard_NC8as_T4_v3 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5 \
  --max-pods 30

#kubectl apply -f Ray/kuberay/RayCluster/Raycluster_CPU.yaml
#kubectl apply -f Ray/kuberay/RayCluster/Raycluster_GPU.yaml

kubectl get raycluster
kubectl get service