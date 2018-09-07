FROM rocker/verse:3.5.1

COPY . /tmp/seu
RUN apt-get update \
    && apt-get install -y libhdf5-dev python3-pip \
    && bash -c "R -f /tmp/seu/install.r"

RUN pip3 install umap-learn 

WORKDIR /tmp/seu
RUN tar -xzf fftw-3.3.8.tgz
WORKDIR /tmp/seu/fftw-3.3.8
RUN ./configure \
    && make \
    && make install

WORKDIR /etc
RUN git clone https://github.com/KlugerLab/FIt-SNE.git
WORKDIR /etc/FIt-SNE
RUN  g++ -std=c++11 -O3  src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm

WORKDIR /
RUN  rm -rf /tmp/* 
CMD /init
