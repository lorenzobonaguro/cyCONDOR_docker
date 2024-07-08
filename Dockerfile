# This docker image is meant for the analysis of high dimensionality flow data with CONDOR v0.1.6

# I start from the Bioconductor 3.17 image with RStudio Server
FROM lorenzobonaguro/cycondor:v015

# Add new packages

## Bioconductor
RUN Rscript -e 'BiocManager::install(c("diffcyt", "ggridges"), version = "3.17")'

## Github
RUN Rscript -e 'devtools::install_github("saeyslab/CytoNorm@362ac08")' 

RUN Rscript -e 'devtools::install_github("immunogenomics/lisi")' 

# install CONDOR v0.1.6
COPY cyCONDOR_0.1.6.tar.gz /tmp/cyCONDOR_0.1.6.tar.gz
RUN Rscript -e 'install.packages("/tmp/cyCONDOR_0.1.6.tar.gz", repos = NULL, type = "source")'

# example to run this docker image
# docker run -dp 8787:8787 -e USER=mariorossi -e PASSWORD=mariorossi --name fc_analysis -v /mnt/e/docker_test:/home/lorenzo/data/ lorenzobonaguro/condor:v014