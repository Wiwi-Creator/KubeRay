import ray
import torch

ray.init()


@ray.remote(num_gpus=0.5)
def gpu_intensive_task(task_id):
    print(f"Task {task_id} started.")

    device = torch.device("cuda")
    a = torch.randn(10000, 10000, device=device)
    b = torch.randn(10000, 10000, device=device)
    result = torch.mm(a, b)

    print(f"Task {task_id} completed.")
    return result


num_tasks = 10
futures = [gpu_intensive_task.remote(i) for i in range(num_tasks)]
results = ray.get(futures)

print("All tasks completed.")
