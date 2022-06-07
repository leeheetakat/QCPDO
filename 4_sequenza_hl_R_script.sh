#!/bin/bash
DOCKER="/usr/bin/docker" #Please modify to docker path for your desktop
IMAGE_NAME="leeheetak/sequenza_hl:latest"
TARGET_VOLUME="/mnt" #in docker virtual machine
HOST_VOLUME="/home" #your local directory

#Load user's input
CASE_ID=$1
TEMP_DATA_DIR=$2
TEMP_OUT_DIR=$3
DATA_DIR=${TEMP_DATA_DIR/home/"mnt"}
OUT_DIR=${TEMP_OUT_DIR/home/"mnt"}

#Implementaion of sequenza R script to get tumorpurity
COMMAND="/usr/bin/Rscript --vanilla /home/sequenza_resources/1_Docker_sequenza_R.R ${CASE_ID} ${DATA_DIR} ${OUT_DIR}"

#Execute docker
CONTAINER_NAME="${CASE_ID}_Rcontainer"
if [[ $(docker ps -a) == *${CONTAINER_NAME}* ]]; then
    ${DOCKER} rm ${CONTAINER_NAME}
fi

if [ ! -d $TEMP_OUT_DIR ]; then
    mkdir ${TEMP_OUT_DIR}
fi

${DOCKER} run -it --name ${CONTAINER_NAME} -v ${HOST_VOLUME}:${TARGET_VOLUME} ${IMAGE_NAME} ${COMMAND}


#Example bash command to execute this .sh file
#$bash 4_sequenza_hl_R_script.sh GA302 /home/heetaklee/hdd/1_qcpdo/x_seqz_test /home/heetaklee/hdd/1_qcpdo/x_seqz_test