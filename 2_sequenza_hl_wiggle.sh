#!/bin/bash
DOCKER="sudo /usr/bin/docker" #Please modify to docker path for your desktop
IMAGE_NAME="leeheetak/sequenza_hl:latest"
TARGET_VOLUME="/mnt"
HOST_VOLUME="/home" 

#Implementaion of sequenza utils bam2seqz
WIG_FILE="/mnt/heetaklee/hdd/1_qcpdo/4_sequenza_build/human_g1k_v37_decoy.wig.gz"
FASTA_FILE="/home/sequenza_resources/human_g1k_v37_decoy.fasta"
COMMAND="/usr/local/bin/sequenza-utils gc_wiggle --fasta ${FASTA_FILE} -o ${WIG_FILE} -w 50"

#Execute docker
CONTAINER_NAME="wiggle_container"
if [[ $(docker ps -a) == *${CONTAINER_NAME}* ]]; then
    ${DOCKER} rm ${CONTAINER_NAME}
fi
${DOCKER} run -it --name ${CONTAINER_NAME} -v ${HOST_VOLUME}:${TARGET_VOLUME} ${IMAGE_NAME} ${COMMAND}


#Example bash command to execute this .sh file
#$bash 2_sequenza_hl_wiggle.sh