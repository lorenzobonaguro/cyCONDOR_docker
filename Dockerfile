# This docker image is meant for the analysis of high dimensionality flow data with CONDOR v0.2.0

# I start from the cyCONDOR v0.1.6 image with RStudio Server
FROM lorenzobonaguro/cycondor:v016

# install cyCONDOR v0.2.0
COPY cyCONDOR_0.2.0.tar.gz /tmp/cyCONDOR_0.2.0.tar.gz
RUN Rscript -e 'install.packages("/tmp/cyCONDOR_0.2.0.tar.gz", repos = NULL, type = "source")'

# example to run this docker image
# docker run -dp 8787:8787 -e USER=mariorossi -e PASSWORD=mariorossi --name fc_analysis -v /mnt/e/docker_test:/home/lorenzo/data/ lorenzobonaguro/cycondor:v020