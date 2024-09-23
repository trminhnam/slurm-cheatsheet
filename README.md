# Slurm Cheatsheet

By: Minh-Nam Tran ^^. Feel free to use it.
For any questions, please contact me at: [trminhnam20082002@gmail.com](mailto:trminhnam20082002@gmail.com)

## Must-know commands

This section will show you some must-know commands to work with slurm.

### Get information of the nodes

In the terminal, run:

```
scontrol show nodes
```

The output will be a list of all nodes with their information as below:

```
NodeName=gpu01 Arch=x86_64 CoresPerSocket=64
   CPUAlloc=36 CPUEfctv=256 CPUTot=256 CPULoad=21.31
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=gpu:8
   NodeAddr=gpu01 NodeHostName=gpu01 Version=xxx
   OS=xxx
   RealMemory=980253 AllocMem=150304 FreeMem=839829 Sockets=2 Boards=1
   State=MIXED ThreadsPerCore=2 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=batch
   BootTime=xxx
   LastBusyTime=xxx
   CfgTRES=cpu=256,mem=980253M,billing=256,gres/gpu=8
   AllocTRES=cpu=36,mem=150304M,gres/gpu=8
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

NodeName=gpu02 Arch=x86_64 CoresPerSocket=24
   CPUAlloc=12 CPUEfctv=48 CPUTot=48 CPULoad=4.32
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=gpu:4
   NodeAddr=gpu02 NodeHostName=gpu02 Version=xxx
   OS=xxx
   RealMemory=244508 AllocMem=48768 FreeMem=192532 Sockets=1 Boards=1
   State=MIXED ThreadsPerCore=2 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=batch
   BootTime=xxx
   LastBusyTime=xxx
   CfgTRES=cpu=48,mem=244508M,billing=48,gres/gpu=4
   AllocTRES=cpu=12,mem=48768M,gres/gpu=3
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

...
...
```

Explanation:

-   `NodeName`: the name of the node.
-   `Gres`: the number of GPUs available on that node.
-   `AllocTRES`: the resources allocated for the node.
-   `CfgTRES`: the total resources of the node.
-   `RealMemory`, `AllocMem`, `FreeMem`: the real memory, the allocated memory, and the free memory of the node.
-   `CPUAlloc`, `CPUEfctv`, `CPUTot`, `CPULoad`: the number of CPUs allocated, the effective number of CPUs, the total number of CPUs, and the CPU load of the node.
-   `Sockets`, `Boards`: the number of sockets and boards of the node.
-   `State`: the state of the node.
-   `Partitions`: the partitions the node belongs to.
-   `BootTime`: the time the node was booted.
-   `LastBusyTime`: the last time the node was busy.
-   `CapWatts`, `CurrentWatts`, `AveWatts`: the capacity watts, the current watts, and the average watts of the node.
-   `ExtSensorsJoules`, `ExtSensorsWatts`, `ExtSensorsTemp`: the external sensors joules, the external sensors watts, and the external sensors temperature of the node.

Pay attention to the `NodeName` and `Gres` fields. The `Gres` field shows the number of GPUs available on that node. For example, `Gres=gpu:8` means that the node has 8 GPUs for Node `gpu01`. We use the `NodeName` to specify the node we want to run the job on.

Watch the CfgTRES and AllocTRES fields to see the total resources and the allocated resources of the node. For example, `CfgTRES=cpu=256,mem=980253M,billing=256,gres/gpu=8` means that the node has 256 CPUs, 980253MB of memory, 256 billing, and 8 GPUs. The `AllocTRES=cpu=36,mem=150304M,gres/gpu=8` means that the node has allocated 36 CPUs, 150304MB of memory, and 8 GPUs. Therefore, this node has no free GPU for training right now.

Considering Node `gpu02`, it has 4 GPUs available (Gres=gpu:4) and 3 GPUs are allocated (AllocTRES=gres/gpu=3). Therefore, it has 1 GPU available for training.

If you want to watch the resources of a specific node, run:

```bash
scontrol show node <node-name>
# example: scontrol show node gpu01
# example output:
# NodeName=gpu01 Arch=x86_64 CoresPerSocket=64
#    CPUAlloc=36 CPUEfctv=256 CPUTot=256 CPULoad=32.38
#    AvailableFeatures=(null)
#    ActiveFeatures=(null)
#    Gres=gpu:8
#    NodeAddr=gpu01 NodeHostName=gpu01 Version=xxx
#    OS=xxx
#    RealMemory=980253 AllocMem=150304 FreeMem=840655 Sockets=2 Boards=1
#    State=MIXED ThreadsPerCore=2 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
#    Partitions=batch
#    BootTime=xxx
#    LastBusyTime=xxx
#    CfgTRES=cpu=256,mem=980253M,billing=256,gres/gpu=8
#    AllocTRES=cpu=36,mem=150304M,gres/gpu=8
#    CapWatts=n/a
#    CurrentWatts=0 AveWatts=0
#    ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
```

### Get running jobs

You can use this command tTthe user who runs the job, the node the job is running on, the status of the job, the time the job has been running, and the name of the job, you can run the following command:

```bash
squeue
```

The output will be a list of running jobs as below:

```
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
  1234     batch  job-1  user-1  R       0:10      1 gpu01
  1235     batch  job-2  user-2  R       0:20      1 gpu02
  1236     batch  job-3  user-3  R       0:30      1 gpu03
```

Explanation:

-   `JOBID`: the ID of the job.
-   `PARTITION`: the partition the job belongs to.
-   `NAME`: the name of the job.
-   `USER`: the user who runs the job.
-   `ST`: the status of the job.
-   `TIME`: the time the job has been running.
-   `NODES`: the number of nodes the job is running on.
-   `NODELIST(REASON)`: the node the job is running on. If the job is not running on any node, the reason will be shown like `(ReqNodeNotAvail, UnavailableNodes:gpu05)`.

If you are not the admin, you can only affect the jobs you have submitted by canceling them.

To watch the job YOU have submitted, run:

```bash
squeue -u $USER

# Example output:
#  JOBID PARTITION     NAME     USER  ST       TIME  NODES NODELIST(REASON)
#  23936     batch refqa_14    xxxxx  PD       0:00      1 (Resources)
#  23918     batch refqa_64    xxxxx   R    4:49:31      1 gpu02
#  23923     batch refqa_14    xxxxx   R    4:42:42      1 gpu01
```

For example, current account is `xxxxx`, and there are 3 jobs submitted by this account. The first job is pending, the second and the third jobs are running on `gpu02` and `gpu01` respectively.

To make the output of `squeue` more readable, you can use the `--format` option to specify the fields you want to show as follows:

```bash
squeue --format="%.18i %.9P %.16j %.8u %.8T %.12M %.12l %.6D %R"
```

where the format string is:

-   `%.18i`: the job ID.
-   `%.9P`: the partition.
-   `%.16j`: the job name.
-   `%.8u`: the user.
-   `%.8T`: the status.
-   `%.12M`: the time the job has been running.
-   `%.12l`: the list of nodes the job is running on.
-   `%.6D`: the number of nodes the job is running on.
-   `%R`: the reason the job is not running.

### Run a shell script with slurm

If you have setup a bash script (named `script.sh` and setup as below) to train your model, you can run it with slurm by running:

```
sbatch <script.sh>
```

Inside the bash script, you MUST specify the resources you need for the job. For example, to train a model with 1 GPU, 4 CPUs, and 16GB of memory, you can specify the resources as below:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --job-name=job-name
#SBATCH --output=log.out
#SBATCH --error=log.out
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
```

Some explanations for the above script:

-   `--nodes=1`: the number of nodes you want to run the job on.
-   `--time=01:00:00`: the time you want to run the job. In this case, the job will run for 1 hour. (format: `days-hours:minutes:seconds`)
-   `--ntasks=1`: the number of tasks you want to run.
-   `--job-name=job-name`: the name of the job.
-   `--output=log.out`: the output file of the job.
-   `--error=log.out`: the error file of the job.
-   `--gres=gpu:1`: the number of GPUs you want to use.
-   `--cpus-per-task=4`: the number of CPUs you want to use.
-   `--mem=16G`: the amount of memory you want to use.

You can run the `script.sh` in this repository to test the slurm setup.
After running the `sbatch` command, you will get a job ID as

```
Submitted batch job 23945
```

And then watch the output of the job by running:

```bash
tail -f log.out -n 10000
```

which is assumed that the output file is `log.out` and the number of lines you want to watch is `10000`.
The output will be the log of the job as below:

````


### Cancel a job

To cancel a job, run:

```bash
scancel <job_id>
````

where `<job_id>` is the job ID of the job you want to cancel. You can get the job ID by running the `squeue` command and check the ID of the job you want to cancel.

## Some extra commands that may be useful for you

### Show current user's statistics

```
sacctmgr show User $USER --associations
```

### Log in to a specific job using `srun`

For a running job, you can execute a command within the job using the `srun` command. For example, to run the `nvidia-smi` command within a job, run:

```bash
srun --jobid=<job_id> nvidia-smi
```

The `--jobid` option specifies the job ID of the job you want to run the command in. You can get the job ID by running the `squeue` command.

### Run an interactive session within a job

In some case, you want to jump into a running job to check the resources, the GPU usage, or the memory usage. You can use the `srun` command to log in to the job. To do that, you need to know the job ID of the job you want to log in to. You can get the job ID by running the `squeue` command.

```bash
srun --jobid=<job_id> --pty bash
```

### Get info of a specific node

To get a specific node's information, run:

```bash
sinfo <node-name>
```

For example, to get the information of node `gpu01`, run:

```bash
sinfo gpu01
```

The output will be the information of the node as below:

```
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
batch*       up 2-00:00:00      2  down* gpu[04-05]
batch*       up 2-00:00:00      3    mix gpu[01-03]
```

Explanation:

-   `PARTITION`: the partition the node belongs to.
-   `AVAIL`: the availability of the node.
-   `TIMELIMIT`: the time limit of the node.
-   `NODES`: the number of nodes.
-   `STATE`: the state of the node.
-   `NODELIST`: the list of nodes.

In this case, the node `gpu01` belongs to the `batch` partition, is up, has a time limit of 2 days, has 3 nodes, is in the mix state, and belongs to the `gpu[01-03]` node list.

### Get all modules available

To get all modules available, run:

```bash
module avail
```

The output will be a list of all modules available as below:

```
---------------------------------------------------------------------------- /sw/spack/share/spack/modules/linux-ubuntu22.04-zen2 -----------------------------------------------------------------------------
cuda-11.5.1-gcc-11.4.0-uvaavrb    cuda-11.8.0-gcc-11.4.0-cuusula            libiconv-1.16-gcc-11.4.0-uvnlivw     pkgconf-1.8.0-gcc-11.4.0-3y5w76g    zlib-1.2.12-gcc-11.4.0-p6wvr2c
...
```
