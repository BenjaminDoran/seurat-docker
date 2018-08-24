FROM rocker/verse:3.5.1

COPY ./install.r /tmp/install.r
RUN apt-get update && apt-get install -y libhdf5-dev && bash -c "R -f /tmp/install.r" && rm -rf /tmp/* 

CMD /init
