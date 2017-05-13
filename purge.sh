#!/bin/bash

# purge.sh
# Deletes older versions (numbered sequences) of the specified file.
#
# @author    Jhonjun Dormitorio [JJD]
# @date      2017.05.13
# @updated   2017.05.13
# @requires  
#
# @usage     purge.sh [-k n] file
#            n number of versions to keep
#
#set -x

keep=0
if [ "${1}" == "-k" ]
then
  shift
  keep="${1}"
  shift
fi

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

if [ -f "${fname}" ]  # Delete only if the base file exists
then
  re='^[0-9]+$'
  purge=`ls -r "${fname}".* 2> /dev/null`
  if [[ ${purge} ]]
  then
    for pfile in ${purge[@]}
    do
      ext="${pfile##*.}"
      if [[ ${ext} =~ ${re} ]]
      then
        if [[ ${keep} > 0 ]]
        then
          keep=$((keep - 1))
          continue
        fi
        #echo "Deleting: ${pfile}"
        rm "${pfile}"
      fi
    done
  fi
fi

