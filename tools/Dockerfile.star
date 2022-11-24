# base image: Ubuntu
FROM continuumio/miniconda3

COPY environment.yml . 
RUN conda env create -f environment.yml
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

FROM ubuntu:22.04

RUN apt-get update --fix-missing \
&& apt-get install -y wget make gcc libz-dev build-essential \

&& cd /usr/local \
&& wget  https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz \
&& tar -xzvf 2.7.10a.tar.gz \
&& rm -rf 2.7.10a.tar.gz \
&& cd STAR-2.7.10a/source \
&& make STAR \
&& mv ./STAR /usr/local/bin/ \
&& cd /usr/local/ \ 
&& rm -rf /usr/local/STAR-2.7.10a \

&& apt-get autoremove -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
ENTRYPOINT ["conda", "python", "usr/local/bin/STAR"]

