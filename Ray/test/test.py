import os
import time
import ray
import torch


# 建立 Ray cluster
# Ray Head Node 如何調度 跨機器的資源? (Cluster 跨機器 , Pod/container 有無需要 request ? , 如何區分 Client(使用 & 背後使用 cluster) , Server 端) -> Kuberay
ray.init(num_cpus=8, num_gpus=2)  # 假設有 1 張 GPU

# 定義任務，使用 0.2 個 GPU
@ray.remote
def fractional_gpu_task():
    pid = os.getpid()
    print(f"Task (Fractional GPU) running on process {pid}.")

    device = torch.device("cuda")
    x = torch.randn(10000, 10000).to(device)
    for _ in range(200):
        x = x @ x  # 矩陣相乘
    return x.norm().item()

# CPU 密集型任務
@ray.remote(num_cpus=2)
def cpu_task():
    pid = os.getpid()
    print(f"Task (CPU) running on process {pid}.")
    result = sum(i * i for i in range(10**7))
    return result

# CPU 輕量級
@ray.remote(num_cpus=0.5)
def lightweight_task():
    pid = os.getpid()
    print(f"Task (Lightweight) running on process {pid}.")
    time.sleep(2)
    return "Lightweight task completed."

# 調度任務
tasks = []
for _ in range(6):  # 創建多個 Fractional GPU 任務
    tasks.append(fractional_gpu_task.remote())

#for _ in range(3):  # 創建多個 CPU 密集型任務
#    tasks.append(cpu_task.remote())

#for _ in range(4):  # 創建多個輕量任務
#    tasks.append(lightweight_task.remote())

results = ray.get(tasks)
print("All tasks completed.")
print(results)

# 關閉 Ray Cluster
#ray.shutdown()