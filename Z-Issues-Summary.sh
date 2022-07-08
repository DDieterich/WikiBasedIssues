#!/bin/bash

awkfile="WikiBasedIssues/Z-Issues-Summary.awk"
if [ ! -s "${awkfile}" ]
then
   echo "Unable to find '${awkfile}' from '${PWD}'."
   echo "Change directory and try again."
   exit -1
fi

ls -U Z[0-9][0-9][0-9][0-9].md |
   while read FILE
   do
      echo "FILENAME  | ${FILE}"
      echo "Modified  | "`date -r "${FILE}" "+%Y%m%d %H%M"`
      head -7 "${FILE}"
   done |
   awk -f "${awkfile}" \
   > ../Z-Issues-Summary.md
