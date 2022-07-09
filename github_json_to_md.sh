#!/bin/bash

# sudo apt install jq

#  Run using: ../WikiBasedIssues/github_json_to_md.sh
#      in a folder that contains dawnloaded issues
#           that is under the Wiki root folder.

awkfile="../WikiBasedIssues/sort_tmplog.awk"
if [ ! -s "${awkfile}" ]
then
   echo "Unable to find '${awkfile}' from '${PWD}'."
   echo "Change directory and try again."
   exit -1
fi

function json_cleanup () {
   sed -e '1,$s/^"//g' \
       -e '1,$s/"$//g' \
       -e '1,$s/^\[\]$//g' \
       -e '1,$s/^null$//g'
   }

ls -U Z[0-9][0-9][0-9][0-9].json |
   while read JSFILE
   do
      MDFILE="../${JSFILE/json/}md"
      if [ -f "${MDFILE}" ]
      then
         echo "Skipping ${MDFILE} - already exists"
         continue
      fi
      echo "Creating ${MDFILE}"
      {  echo -n "Issue     | "; jq ".title"           "${JSFILE}" | json_cleanup
         echo -n "----------|-"; echo "---------"
         echo -n "Status    | "; jq ".state"           "${JSFILE}" | json_cleanup
         echo -n "Assigned  | "; jq ".assignee.login"  "${JSFILE}" | json_cleanup
         #echo -n "Assignees | "; jq ".assignees"       "${JSFILE}" | json_cleanup
         echo -n "Milestone | "; jq ".milestone.title" "${JSFILE}" | json_cleanup
         echo -n "Est Hrs   | "; echo ""
         echo -n "%Complete | "; echo ""
         echo -n "Labels    | "
         i=0
         label_name=`jq ".labels[${i}].name" "${JSFILE}" | json_cleanup`
         while [ ! -z "${label_name}" \
                   -a "${label_name}" != "null" \
                   -a "${i}" -lt 100 ]
         do
            if [ "${i}" = "0" ]
            then
               echo -n "${label_name}"
            else
               echo -n ", ${label_name}"
            fi
            let i=${i}+1
            label_name=`jq ".labels[${i}].name" "${JSFILE}" | json_cleanup`
         done
         echo ""
         echo -n "Links     | "; echo "[Issues Summary](Z-Issues-Summary)"
         echo ""
         echo ""
         echo "## Description"
         echo ""
         jq ".body" "${JSFILE}" | json_cleanup
         echo ""
         echo ""
         echo ""
         echo ""
         echo "## Resolution"
         echo ""
         echo ""
         echo ""
         echo ""
         echo "## Issue Log"
         echo "*(Add newest entries on top and add Date/Time and Author for each entry.)*"
         echo ""
         {  nc=`jq ".comments" "${JSFILE}"`
            i=0
            while [ "${i}" -lt "${nc}" ]
            do
               cmt_usr=`jq ".[${i}].user.login" "${JSFILE/[.]json/_comments.json}" | json_cleanup`
               cmt_dtm=`jq ".[${i}].created_at" "${JSFILE/[.]json/_comments.json}" | json_cleanup`
               echo "${cmt_dtm}" $'\v' "${cmt_usr}" $'\v'
               jq ".[${i}].body"       "${JSFILE/[.]json/_comments.json}" | json_cleanup
               echo -n $'\f'
               let i=${i}+1
            done
            i=0
            event_txt=`jq ".[${i}].event"       "${JSFILE/[.]json/_events.json}" | json_cleanup`
            while [ ! -z "${event_txt}" ]
            do
               event_usr=`jq ".[${i}].actor.login" "${JSFILE/[.]json/_events.json}" | json_cleanup`
               event_dtm=`jq ".[${i}].created_at"  "${JSFILE/[.]json/_events.json}" | json_cleanup`
               echo "${event_dtm}" $'\v' "${event_usr}" $'\v' "${event_txt}"
               echo -n $'\f'
               let i=${i}+1
               event_txt=`jq ".[${i}].event"       "${JSFILE/[.]json/_events.json}" | json_cleanup`
            done
         } | awk -f "${awkfile}"
         echo ""
      } | sed -e '1,$s/[\]r/\r/g' -e '1,$s/[\]n/\n/g' \
        > "${MDFILE}"
   done
