This Pipeline covers sequenza tumor purity from .bam file. 

-Dependency: Docker, bash

Please follow the procedures as below: 
1. Pulling docker image via 'docker pull sequenza:version8' on bash env. 
2. To implement bam2seqz, type '$bash 3_sequenza_hl_bam2seqz.sh [BAMfile directory] [NORMAL_BAM file name] [TUMOR_BAM file name] [SAMPLE_ID] [OUT_DIR]'
#CAUTION: Bascially, the docker image/container uses /home directory for your PC/server by mounting with /mnt directory. 
#NOTE: You can make .sh file which contains such commandlines for multiple samples. 
3. After generating .seqz files from proc.2, you can run 'Rscript' to estimate tumore purity with this command: '$bash 4_sequenza_hl_R_script.sh [SAMPLE_ID] [.seqz FILE DIR] [OUT_DIR]'
#CAUTION: Sequenza will generate file set for each sample under 'OUT_DIR/SAMPLE_ID'.

FIN. 


