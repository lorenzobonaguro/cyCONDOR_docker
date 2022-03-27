# This docker image is meant for the analysis of high dimensionality flow data

# I start from the basic bioconductor image with R3.6.2 and bioconductor 3.10
FROM lorenzobonaguro/flowtools:R362_V2

# Install HUVA
COPY condor_0.1.0.tar.gz /tmp/condor_0.1.0.tar.gz
RUN Rscript -e 'install.packages("/tmp/condor_0.1.0.tar.gz", repos = NULL, type = "source")'