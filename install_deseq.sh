sudo apt-get update --fix-missing \
apt install -y r-base \

R -e 'install.packages("BiocManager")
	BiocManager::install("DESeq2")'
