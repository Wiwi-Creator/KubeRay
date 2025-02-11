#hel install NVIDIA GPU Operator
helm install --wait --generate-name \
    -n gpu-operator \
    --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.1 \
    --set mig.strategy=single

# GPU Operator Install with CSP
helm install --wait --generate-name \
    -n gpu-operator --create-namespace \
    nvidia/gpu-operator \
    --version=v24.9.1 

helm install gpu-operator nvidia/gpu-operator \
    -n gpu-operator --create-namespace \
    --version=v24.9.1 \
    --set mig.strategy=mixed

# helm install device plugin
helm install nvdp nvdp/nvidia-device-plugin \
    --version=0.15.0 \
    --set migStrategy=mixed \
    --set gfd.enabled=true \
    --namespace nvidia-device-plugin \
    --create-namespace

# check namespace
kubectl get pods -n gpu-operator

kubectl apply -f samples-tf-mnist-demo.yaml
kubectl get jobs samples-tf-mnist-demo --watch

# test GPU slicing 
kubectl apply -f single-strategy-example.yaml
kubectl exec nvidia-single -- nvidia-smi -L

kubectl apply -f mixed-strategy-example.yaml
kubectl exec nvidia-mixed1 -- nvidia-smi -L

# helm list
helm list -n gpu-operator
# helm uninstall gpu-operator
