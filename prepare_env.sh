#!/bin/bash
mkdir -p /opt/bigdl/
cd /opt/bigdl/
mkdir ~/.pip
echo -e "[global]\\nindex-url = http://mirrors.aliyun.com/pypi/simple/\\n\\n[install]\\ntrusted-host=mirrors.aliyun.com\\n"  > ~/.pip/pip.conf

wget http://tutorial.bj.bcebos.com/dist-spark-2.1.1-scala-2.11.8-all-0.5.0-dist.zip -O dist-spark-2.1.1-scala-2.11.8-all-0.5.0-dist.zip
mkdir dist-spark-2.1.1-scala-2.11.8-all-0.5.0-dist
unzip -o dist-spark-2.1.1-scala-2.11.8-all-0.5.0-dist.zip -d dist-spark-2.1.1-scala-2.11.8-all-0.5.0-dist

wget http://tutorial.bj.bcebos.com/Miniconda2-latest-Linux-x86_64.sh -O Miniconda2-latest-Linux-x86_64.sh
export PATH=/root/miniconda2/bin:$PATH

bash Miniconda2-latest-Linux-x86_64.sh -b
conda create -y -n py2bigdl python=2.7

echo -e "channels:\\n - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/\\n - defaults\\nssl_verify: true\\nshow_channel_urls: true" > ~/.condarc
source activate py2bigdl
pip install keras==1.2.2
pip install tensorflow==1.0.0
pip install h5py
#pip install --no-dependencies BigDL==0.5.0
conda install -y jupyter
conda install -y pandas
conda install -y matplotlib

# download some data
mkdir -p  ~/.keras/models
cd ~/.keras/models
wget http://tutorial.bj.bcebos.com/imagenet_class_index.json
wget http://tutorial.bj.bcebos.com/resnet50_weights_th_dim_ordering_th_kernels.h5

mkdir -p ~/.keras/datasets/mnist
cd ~/.keras/datasets/mnist

wget http://tutorial.bj.bcebos.com/mnist%2Ft10k-images-idx3-ubyte.gz -O t10k-images-idx3-ubyte.gz
wget http://tutorial.bj.bcebos.com/mnist%2Ft10k-labels-idx1-ubyte.gz -O t10k-labels-idx1-ubyte.gz
wget http://tutorial.bj.bcebos.com/mnist%2Ftrain-images-idx3-ubyte.gz -O train-images-idx3-ubyte.gz
wget http://tutorial.bj.bcebos.com/mnist%2Ftrain-labels-idx1-ubyte.gz -O train-labels-idx1-ubyte.gz

mkdir ../census
wget http://tutorial.bj.bcebos.com/census%2Fadult.data -O ../census/adult.data
wget http://tutorial.bj.bcebos.com/census%2Fadult.test -O ../census/adult.test

# create user dir and upload some data to hdfs
sudo -u hdfs hdfs dfs -mkdir -p  /user/root
sudo -u hdfs hdfs dfs -chown -R root /user/root
hdfs dfs -put ../census /user/root
