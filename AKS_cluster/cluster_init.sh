#建立 cluster
az aks create --resource-group AKS-resource-group \
              --name AA-standard \
              --tier standard \
              --enable-cluster-autoscaler \
              --min-count 1 \
              --max-count 3 \
              --location eastus2 \
              --os-sku Ubuntu \
              --azure-keyvault-kms-key-vault-network-access Public

az aks get-credentials --resource-group AKS-resource-group --name AA-standard

helm install kuberay-operator kuberay/kuberay-operator --version 1.2.2

helm install gpu-operator nvidia/gpu-operator -n gpu-operator --create-namespace --version=v24.9.1

sh node/T4_node.sh
# az aks show --resource-group AKS-resource-group --name AA-standard --output table
