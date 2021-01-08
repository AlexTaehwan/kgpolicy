#!/usr/bin/bash

#SBATCH --job-name=kg-policy
#SBATCH --output=logs/%x-%j.out
#SBATCH -A st_graphs
#SBATCH -p dlt
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH -t 47:59:00

wget https://github.com/xiangwang1223/kgpolicy/releases/download/v1.0/Data.zip 
unzip Data.zip

REPO_DIR=~/recommendation/knowledge_graph_policy_network
cd kgpolicy
conda create -n geo python=3.6
conda activate geo
bash setup.sh

python main.py
python main.py --regs 1e-4 --dataset yelp2018 --model_path model/best_yelp.ckpt 
python main.py --regs 1e-4 --dataset amazon-book --model_path model/best_ab.ckpt 