#!/usr/bin/bash

#SBATCH --job-name=kgpolicy
#SBATCH --output=logs/%x-%j.out
#SBATCH -A ST_GRAPHS
#SBATCH -p shared_dlt
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH --gres=gpu:1
#SBATCH -t 3-23:59:00

module purge
module load cuda/9.2.148 
module load python/anaconda3.2019.3
module load gcc/5.2.0
source /share/apps/python/anaconda3.2019.3/etc/profile.d/conda.sh
source activate kgpolicy

REPO_DIR=~/recommendation/KG-Policy/kgpolicy
cd $REPO_DIR

model=kgpolicy

printf "Running all datasets"
date
printf "Running ${model} on last-fm\n"
python main.py
date
printf "Running ${model} on yelp2018\n"
python main.py \
    --regs 1e-4 \
    --dataset yelp2018 \
    --model_path model/best_yelp.ckpt 
date
printf "Running ${model} on amazon-book\n"
python main.py \
    --regs 1e-4 \
    --dataset amazon-book \
    --model_path model/best_ab.ckpt
printf "Finished"
