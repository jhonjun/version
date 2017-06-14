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
set -x

srcfile=${1}
fname="${srcfile%.*}"
origname="${fname}"

echo "${srcfile}" | grep "\." > /dev/null
[[ ${?} == 0 ]] && ext="${srcfile##*.}" || ext=""

numext=$((ext))
[[ ${ext} && ${numext} == 0 ]] && fname="${fname}.${ext}"

newfile=`\ls -r "${fname}".* 2> /dev/null | head -n1`
if [[ ${newfile} ]]
then
  ext="${newfile##*.}"
  origname="${newfile%.*}"
fi
numext=$((ext))

prev=`printf "%03d" $((numext))`
/usr/bin/cmp "${fname}" "${fname}.${prev}" 2> /dev/null
if [[ ${?} != 0 ]]
then
  next=`printf "%03d" $((numext + 1))`
  newfile="${origname}.${next}"
  cp "${origname}" "${newfile}"
fi

