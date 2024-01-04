# slurm-cheatsheet

By: Minh-Nam Tran ^^. Feel free to use it.

### Run a shell script with slurm

```
sbatch <script.sh>
```

### Show all information of nodes

```
scontrol show nodes
```

### Get info of a specific node

```
sinfo <node-name>
```

or

```
scontrol show node gpu01
```

### Get running jobs

```
squeue
```

### Show current user's statistics

```
sacctmgr show User $USER --associations
```

### Log in to a specific job using `srun`

```
srun --jobid=<job_id> nvidia-smi
```

### Run an interactive session within a job

```bash
srun --jobid=<job_id> --pty bash
```

srun --jobid=219 --pty bash
