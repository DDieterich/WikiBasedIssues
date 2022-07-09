#!/bin/bash

#  Run using: WikiBasedIssues/create_issues_summary.sh

summfile="Z-Issues-Summary.md"
awkfile="WikiBasedIssues/create_issues_summary.awk"
if [ ! -s "${awkfile}" ]
then
   echo "Unable to find '${awkfile}' from '${PWD}'."
   echo "Change directory and try again."
   exit -1
fi

ls -U Z[0-9][0-9][0-9][0-9].md |
   {  while read FILE
      do
         echo "FILENAME  | ${FILE}"
         echo "Modified  | "`date -r "${FILE}" "+%Y%m%d %H%M"`
         head -7 "${FILE}"
      done
      echo "Timezone: "`date -r . "+%Z (%:z)"`
   } | awk -f "${awkfile}" \
       > "${summfile}"
