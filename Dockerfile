FROM rocker/verse:3.5.1

COPY . /tmp/seu
RUN apt-get update \
    && apt-get install -y libhdf5-dev python3-pip \
    && bash -c "R -f /tmp/seu/install.r"
RUN pip3 install umap-learn 
RUN cd /tmp/seu \
    && tar -xzf fftw-3.3.8.tgz \
    && ./configure \
    && make \
    && make install
RUN git clone git@github.com:KlugerLab/FIt-SNE.git /etc/FIt-SNE/ \
    && cd /etc/FIt-SNE \
    && g++ -std=c++11 -O3  src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm
RUN  rm -rf /tmp/* 
CMD /init
