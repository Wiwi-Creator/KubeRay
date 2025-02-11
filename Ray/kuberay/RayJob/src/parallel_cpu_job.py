import ray

ray.init()


@ray.remote
def cpu_intensive_task(task_id):
    print(f"Task {task_id} started.")
    result = sum(i * i for i in range(10**6))
    print(f"Task {task_id} completed.")
    return result


num_tasks = 5  # 提交 5 个任务
futures = [cpu_intensive_task.remote(i) for i in range(num_tasks)]
results = ray.get(futures)
print("All tasks completed.")
print("Results:", results)
