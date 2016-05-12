#!/bin/sh
# -----------------------------------------------------
# General purpose backup script
# author : mdjae
# -----------------------------------------------------

echo "Get the Party started ! .... "
echo "-------------------------------------------------"
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
  # -T disable pseudo-tty allocation
  ssh -T ${SRV[0]}@$${SRV[1]} < /opt/extract-dump.sh

done

#TODO : rsync -0av --progress

duration=$SECONDS
echo "The party stop after $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
SUBJECT=“Automated Security Alert”
TO=“alarms@ariejan.net”
MESSAGE="The party stop after $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."


/usr/bin/mail -s "$SUBJECT" "$TO" < $MESSAGE


