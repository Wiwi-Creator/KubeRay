import ray
import torch
import time

ray.init()


@ray.remote(memory=1 * 1024 * 1024 * 1024, num_cpus=1, num_gpus=0.5)  # 每個任務使用 1 張 GPU
def gpu_intensive_task(task_id):
    print(f"Task {task_id} started on GPU.")

    device = torch.device("cuda")  # 確保運行在 GPU 上
    a = torch.randn(10000, 10000, device=device)  # 在 GPU 上創建矩陣
    b = torch.randn(10000, 10000, device=device)  # 在 GPU 上創建矩陣
    result = torch.mm(a, b)  # 在 GPU 上進行矩陣乘法

    print(f"Task {task_id} completed on GPU.")
    time.sleep(10)  # 模擬長時間運行
    return result.cpu().numpy()  # 返回 CPU 結果，避免 GPU 記憶體洩漏


num_tasks = 20  # 執行 5 個並行任務
futures = [gpu_intensive_task.remote(i) for i in range(num_tasks)]
results = ray.get(futures)

print("All GPU tasks completed.")
