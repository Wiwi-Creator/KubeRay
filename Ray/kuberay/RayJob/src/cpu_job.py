import ray
import time

ray.init()


@ray.remote
def cpu_intensive_task(task_id):
    print(f"Task {task_id} started.")
    result = sum(i * i for i in range(10**7))
    print(f"Task {task_id} completed.")
    time.sleep(10)
    return result


num_tasks = 10
futures = [cpu_intensive_task.remote(i) for i in range(num_tasks)]  # For image list
results = ray.get(futures)
print("All tasks completed.")
print("Results:", results)
print("Sleeping for 60 seconds to keep the job alive...")
