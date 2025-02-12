import ray
import time
import torch


ray.init()


@ray.remote(num_gpus=0.5, resources={"gpu_node": 1})
def gpu_intensive_task(task_id):
    print(f"GPU Task {task_id} started.")
    device = torch.device("cuda")
    a = torch.randn(10000, 10000, device=device)
    b = torch.randn(10000, 10000, device=device)
    result = torch.mm(a, b)
    time.sleep(60)
    print(f"GPU Task {task_id} completed.")
    return result


@ray.remote(num_cpus=1)
def cpu_intensive_task(task_id):
    print(f"CPU Task {task_id} started.")
    result = sum(i * i for i in range(10000000))
    time.sleep(60)
    print(f"CPU Task {task_id} completed.")
    return result


num_tasks = 20
gpu_futures = [gpu_intensive_task.remote(i) for i in range(num_tasks)]
cpu_futures = [cpu_intensive_task.remote(i) for i in range(num_tasks)]
results_gpu = ray.get(gpu_futures)
results_cpu = ray.get(cpu_futures)

print("All tasks completed.")
