FROM rocker/verse:3.5.1

COPY . /tmp/seu
RUN apt-get update \\
    # Dependency for Seurat
    && apt-get install -y libhdf5-dev \\
    # R dependencies and Seurat
    && bash -c "R -f /tmp/seu/install.r" \\
    # UMAP 
    && pip install umap-learn \\
    # FItSNE 
    && tar -C -xzf /tmp/seu/fftw-3.3.8.tgz \\
    && /tmp/seu/fftw-3.3.8/configure \\
    && make -C /tmp/seu/fftw-3.3.8/ \\
    && make -C /tmp/seu/fftw-3.3.8/ install \\
    && git clone git@github.com:KlugerLab/FIt-SNE.git /etc/FIt-SNE/ \\
    && cd /etc/FIt-SNE && g++ -std=c++11 -O3  src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm \\
    # clean tmp folder
    && rm -rf /tmp/* 

CMD /init
