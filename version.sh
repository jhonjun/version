#!/bin/bash

# version.sh
# A quick way to make a backup of your file with a sequential version number
# before you make any changes to it.
#
# @author    Jhonjun Dormitorio [JJD]
# @date      2017.05.13
# @updated   2017.05.13
# @requires  
#
# @usage     version.sh file
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
  ext="${newfile##*.}"
fi
numext=$((ext))

next=`printf "%03d" $((numext + 1))`
newfile="${fname}.${next}"

cp "${fname}" "${newfile}"

