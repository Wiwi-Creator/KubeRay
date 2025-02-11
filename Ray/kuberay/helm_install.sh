helm install kuberay-operator kuberay/kuberay-operator --version 1.2.2

#helm install raycluster kuberay/ray-cluster --version 1.2.2

#kubectl get pods --selector=ray.io/cluster=raycluster-kuberay

#kubectl exec -it raycluster-kuberay-head-t4m97  -- python -c "import ray; ray.init(); print(ray.cluster_resources())"