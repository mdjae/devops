#!/bin/sh
# -----------------------------------------------------
# General purpose backup script
# author : mdjae
# -----------------------------------------------------

# Set start time 
SECONDS=0
DATE='data +%d%m%y'

# Remote server config 
# Add server with REMOTESRV[n]=IP|USER|PATH

REMOTESRV[0]=xx.xxx.xxx.xxx:bckp:/var/www
#REMOTESRV[1]=xx.xxx.xxx.xxx:bckp:/var/www
#REMOTESRV[2]=xx.xxx.xxx.xxx:bckp:/var/www
for elt in ${REMOTESRV[@]}
do  
  IFS=':' read -a SRV <<< "$elt"
  # Execute backup command on remote server
  ssh ${SRV[0]}@$${SRV[1]} ${SRV[2]} 

done
