# 開 AKS Cluster
sh AKS_cluster/cluster_init.sh
# 建立 CPU Node Pool b4m
sh AKS_cluster/node/cpu_node.sh
# Install KubeRay via Helm
helm install kuberay-operator kuberay/kuberay-operator --version 1.2.2

kubectl apply -f Ray/kuberay/RayCluster/Raycluster_CPU.yaml
kubectl get raycluster
kubectl get service

cd Ray/kuberay/RayJob

ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py

# 一次性提交 Ray Job
ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py --job-id 1 &
ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py --job-id 2 &
ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py --job-id 3 &
ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py --job-id 4 &
ray job submit --address='http://52.177.48.205:8265' --working-dir src -- python cpu_job.py --job-id 5 
