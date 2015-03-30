#!/bin/sh
# require : appt-get install lftp
# Deployment script with lftp command


# Credentials FTP

puser="username"
pass="password"
host="ftp.domaine.com"


# Declare config for Update fonction
# Path and exclude dir

path_local="`pwd`/"
path_remote="/"
excludes=(".svn/" ".git/" "sessions/" "tmp/" "report/" "log/" "saves/" "www/caches/" "www/upload/")


# Add exclusion role to Update command

s_excludes=""
for (( i_exclude=0; i_exclude < ${#excludes[@]}; ++i_exclude ))
do
    s_excludes="${s_excludes}-x ${excludes[$i_exclude]} "
done


# Start Update
#  -R for reverse command 
# TODO : In case backup delete -R attribut

lftp "ftp://${user}:${pass}@${host}" -e "mirror --verbose=3 -e -R ${s_excludes} ${path_local} ${path_remote} ; quit"
