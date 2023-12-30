#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=gpu_check
#SBATCH --output=logs/gpu.%j.out
#SBATCH --error=errors/gpu.%j.err
#SBATCH --gres=gpu:8
#SBATCH --nodelist=gpu01

# Check GPU availability
nvidia-smi
python -m bitsandbytes