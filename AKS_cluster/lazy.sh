# 開 AKS Cluster
sh AKS_cluster/cluster_init.sh
# 建立 CPU Node Pool b4m
#sh AKS_cluster/node/cpu_node.sh
# Install KubeRay via Helm
helm install kuberay-operator kuberay/kuberay-operator --version 1.2.2

az aks nodepool add \
  --resource-group AKS-resource-group \
  --cluster-name AA-standard \
  --name t4pool \
  --mode User \
  --os-sku Ubuntu \
  --kubernetes-version 1.30.7 \
  --node-vm-size Standard_NC4as_T4_v3 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5 \
  --max-pods 30

#kubectl apply -f Ray/kuberay/RayCluster/Raycluster_CPU.yaml
#kubectl apply -f Ray/kuberay/RayCluster/Raycluster_GPU.yaml
kubectl get raycluster
kubectl get service