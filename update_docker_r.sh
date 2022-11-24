# pull r-base
docker pull r-base

# run R docker image in background
docker run -d -v $PWD=$PWD --entrypoint bash -i -t r-base:latest

# get last docker name and id
NAME=$(docker ps -a |sed -n '2p' |awk '{print $NF}')
ID=$(docker ps -a |sed -n '2p' |awk '{print $1}')

# execute commands in R docker container
docker exec $NAME apt-get update --fix-missing
docker exec $NAME apt-get install -y libssl-dev libcurl4-openssl-dev libxml2-dev gfortran
docker exec $NAME R -e 'if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")'

docker commit $ID r-deseq2:4.2
docker stop $NAME
