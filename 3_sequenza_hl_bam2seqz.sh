#!/bin/bash
DOCKER="sudo /usr/bin/docker" #Please modify to docker path for your desktop
IMAGE_NAME="leeheetak/sequenza_hl:latest"
TARGET_VOLUME="/mnt"
HOST_VOLUME="/home" 

#Load user's input
TEMP_BAM_PATH=$1
NORMAL_BAM=$2
TUMOR_BAM=$3
CASE_ID=$4
TEMP_OUT_DIR=$5
BAM_PATH=${TEMP_BAM_PATH/home/"mnt"}
OUT_DIR=${TEMP_OUT_DIR/home/"mnt"}

#Implementaion of sequenza utils bam2seqz
WIG_FILE="/home/sequenza_resources/human_g1k_v37_decoy.wig.gz"
FASTA_FILE="/home/sequenza_resources/human_g1k_v37_decoy.fasta"
COMMAND="/usr/local/bin/sequenza-utils bam2seqz -n ${BAM_PATH}/${NORMAL_BAM} -t ${BAM_PATH}/${TUMOR_BAM} --fasta ${FASTA_FILE} -gc ${WIG_FILE} -o ${OUT_DIR}/${CASE_ID}.seqz.gz"

#Execute docker
CONTAINER_NAME="${CASE_ID}_container"
if [[ $(docker ps -a) == *${CONTAINER_NAME}* ]]; then
    ${DOCKER} rm ${CONTAINER_NAME}
fi


${DOCKER} run -it --name ${CONTAINER_NAME} -v ${HOST_VOLUME}:${TARGET_VOLUME} ${IMAGE_NAME} ${COMMAND}


#Example bash command to execute this .sh file
#$bash 3_sequenza_hl_bam2seqz.sh /home/heetaklee/hdd/1_qcpdo/1_bam_dump/1_KOR_GC GA302NP13.recal.bam GA302TO67.recal.bam GA302 /home/heetaklee/hdd/1_qcpdo/x_seqz_test 