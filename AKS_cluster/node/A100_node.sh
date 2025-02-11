#建立node pool
az aks nodepool add \
  --resource-group AKS-resource-group \
  --cluster-name AA-standard \
  --name migpoc \
  --node-vm-size Standard_NC24ads_A100_v4 \
  --node-count 1 \
  --os-sku Ubuntu \
  --gpu-instance-profile MIG1g