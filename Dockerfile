# base image: Ubuntu
FROM ubuntu:22.04
RUN apt-get update --fix-missing \
&& apt-get install -y wget gcc make libbz2-dev zlib1g zlib1g-dev liblzma5 liblzma-dev libncurses5 libncurses5-dev bzip2 \
&& cd /usr/local/ \
&& wget -O samtools.tar.bz2 https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 \
&& tar -xjvf samtools.tar.bz2 \
&& rm -rf samtools.tar.bz2 \
&& cd samtools-1.9 \
&& ./configure \
&& make \
&& make install \
&& cd /usr/local \
&& rm -rf /usr/local/samtools-1.9 \

&& wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz \
&& tar -vxzf sratoolkit.tar.gz \
&& rm -rf sratoolkit.tar.gz \
&& export PATH=$PATH:$PWD/sratoolkit.3.0.0-ubuntu64/bin \
&& vdb-config \ 

&& apt-get remove -y wget gcc make libbz2-dev zlib1g-dev liblzma-dev libncurses-dev bzip2 \
&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
ENTRYPOINT ["/usr/local/bin/projet"]

