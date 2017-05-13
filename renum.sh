#!/bin/bash

# renum.sh
# Renumbers the version sequence of the specified file.
#
# @author    Jhonjun Dormitorio [JJD]
# @date      2017.05.13
# @updated   2017.05.13
# @requires  
#
# @usage     renum.sh file
#
#set -x

srcfile=${1}
fname="${srcfile%.*}"

echo "${srcfile}" | grep "\." > /dev/null
[[ ${?} == 0 ]] && ext="${srcfile##*.}" || ext=""

newfile=`ls -r "${fname}".* 2> /dev/null | head -n1`
if [[ ${newfile} ]]
then
  numext=$((ext))
  [[ ${ext} && ${numext} == 0 ]] && fname="${fname}.${ext}"
fi

re='^[0-9]+$'
newver=1
renum=`ls "${fname}".* 2> /dev/null`
if [[ ${renum} ]]
then
  for pfile in ${renum[@]}
  do
    ext="${pfile##*.}"
    if [[ ${ext} =~ ${re} && $((ext > newver)) ]]
    then
      newext=`printf "%03d" $((newver))`
      #echo "Renaming: ${pfile} to ${fname}.${newext}"
      mv "${pfile}" "${fname}.${newext}"
      newver=$((newver + 1))
    fi
  done
fi

