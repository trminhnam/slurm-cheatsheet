#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --job-name=run
#SBATCH --output=log.out
#SBATCH --error=log.out
#SBATCH --gres=gpu:3
#SBATCH --nodelist=gpu02
#SBATCH --cpus-per-task=12

# cd /usr/local/cuda-12/lib64
# ls -laF

# cd cuda
# ls -laF # cuda
# ls -laF cuda-12/lib64/stubs

# pip install torch torchvision torchaudio
# nvidia-smi

# pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cu121
# pip install -r requirements.txt

python -c 'import torch; print(torch.cuda.is_available())'

# python check.py
# which nvcc
# nvidia-smi
# pip install flash-attn --verbose --no-cache-dir


cd ../test_cuda
./cuda_check