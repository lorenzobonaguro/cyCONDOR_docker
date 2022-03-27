# CONDOR docker image

Docker image for the analysis of HDFC data with the CONDOR package


## example to run this docker image
docker run -dp 8787:8787 -e USER=mariorossi -e PASSWORD=mariorossi --name fc_analysis -v /mnt/e/docker_test:/home/mariorossi/data/ lorenzobonaguro/condor:v010