# This docker image is meant for the analysis of high dimensionality flow data with CONDOR

# I start from the Bioconductor 3.17 image with RStudio Server
FROM bioconductor/bioconductor_docker:RELEASE_3_17

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

RUN rm /root/miniconda.sh

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Add the conda repositories
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

# Prepare the enviroment for Astir
RUN conda create --name astir python=3.7

## Install astir in this conda
RUN cd /opt && git clone https://github.com/camlab-bioml/astir.git && cd astir && conda run -n astir pip install .

RUN rm -r /opt/astir

# installing necessary packages (CRAN + Bioconductor)
RUN Rscript -e 'BiocManager::install(update = T, ask = F, version = "3.17")' && \
    Rscript -e 'BiocManager::install(c("flowCore", "devtools", "Rtsne", "umap", "ggplot2", "ggpubr",  \
                                       "vegan", "diffusionMap", "FlowSOM", "gplots", "grid", "gridExtra", \
                                       "reshape2", "RColorBrewer", "scatterplot3d", "rgl", "Biobase", "Rmisc", \
                                       "tidyverse", "pheatmap", "viridis", "rainbow", "destiny", \
                                       "SingleCellExperiment", "slingshot", "ggrastr", \
                                       "uwot", "FlowSOM", "caret", "factoextra", "harmony", "flowWorkspace", \
                                       "CytoML", "Biobase", "Hmisc", "CytoDx", "DelayedMatrixStats"), version = "3.17")'

RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/randomForest_4.7-1.1.tar.gz", repos=NULL, type="source")'

# install github packages
RUN Rscript -e 'devtools::install_github("JinmiaoChenLab/Rphenograph")' && \
    Rscript -e 'devtools::install_github("stuchly/Rphenoannoy")'

# install CONDOR
COPY cyCONDOR_0.1.5.tar.gz /tmp/cyCONDOR_0.1.5.tar.gz
RUN Rscript -e 'install.packages("/tmp/cyCONDOR_0.1.5.tar.gz", repos = NULL, type = "source")'

# example to run this docker image
# docker run -dp 8787:8787 -e USER=mariorossi -e PASSWORD=mariorossi --name fc_analysis -v /mnt/e/docker_test:/home/lorenzo/data/ lorenzobonaguro/condor:v014