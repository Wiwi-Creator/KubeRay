#建立 cluster
az aks create --resource-group AKS-resource-group \
              --name AA-standard \
              --tier standard \
              --enable-cluster-autoscaler \
              --min-count 1 \
              --max-count 3 \
              --location eastus2 \
              --os-sku Ubuntu \
              --azure-keyvault-kms-key-vault-network-access Public \

az aks get-credentials --resource-group AKS-resource-group --name AA-standard

az aks show --resource-group AKS-resource-group --name AA-standard --output table

#建立node pool
az aks nodepool add \
  --resource-group AKS-resource-group \
  --cluster-name AA-standard \
  --name miggpu \
  --node-vm-size Standard_NC24ads_A100_v4 \
  --node-count 1 \
  --os-sku Ubuntu \
  --gpu-instance-profile MIG1g


helm install nvdp nvdp/nvidia-device-plugin \
    --version=0.15.0 \
    --set migStrategy=mixed \
    --set gfd.enabled=true \
    --namespace nvidia-device-plugin \
    --create-namespace
