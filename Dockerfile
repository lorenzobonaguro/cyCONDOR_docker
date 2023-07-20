# This docker image is meant for the analysis of high dimensionality flow data

# I start from the flowtools image with R3.6.2 and bioconductor 3.10
FROM lorenzobonaguro/flowtools:R362_V2

# Install some missing Ubuntu libraries
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y tk

# Install extra packages
RUN Rscript -e 'devtools::install_github("cran/rainbow@3.6")'

RUN Rscript -e 'devtools::install_github("stuchly/Rphenoannoy")'

RUN Rscript -e 'BiocManager::install(c("uwot", "FlowSOM"), version = "3.10")'

RUN Rscript -e 'BiocManager::install("caret", version = "3.10")'

RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.6-14.tar.gz", repos=NULL, type="source")'

# Install CONDOR
COPY condor_0.1.2.tar.gz /tmp/condor_0.1.2.tar.gz
RUN Rscript -e 'install.packages("/tmp/condor_0.1.2.tar.gz", repos = NULL, type = "source")'
