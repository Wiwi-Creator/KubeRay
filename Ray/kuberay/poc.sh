
cd Ray/kuberay/RayJob

ray job submit --address='http://4.153.161.161:8265' --working-dir src -- python cpu_job.py

ray job submit --address='http://48.214.39.30:8265' --working-dir src -- python gpu_job.py