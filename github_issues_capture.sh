#!/bin/bash

# Requires a "TOKEN" to read the issues reqository.
#  Optionally, provide a value for TOKEN as 1st Command line Parameter.
if [ ! -z "${1}" ]
then
   TOKEN="${1}"
fi
if [ -z "${TOKEN}" ]
then
   echo "No value for TOKEN"
   exit -1
fi

# Requires the ID of the last Issue in the repository
#  Optionally, provide a value for lAST_ID as 2nd Command line Parameter.
if [ ! -z "${2}" ]
then
   LAST_ID="${2}"
fi
if [ -z "${LAST_ID}" ]
then
   echo "No value for LAST_ID"
   exit -2
fi

gh_id=1
while [ ${gh_id} -le "${LAST_ID}" ]
do
   printf -v fn_id "%04i" ${gh_id}
   #echo "${gh_id}, ${fn_id}"
   curl -H "Authorization: token ${TOKEN}" \
      "https://api.github.com/repos/DMSTEX/DMSTEX/issues/${gh_id}" \
      > "Z${fn_id}.json"
   curl -H "Authorization: token ${TOKEN}" \
      "https://api.github.com/repos/DMSTEX/DMSTEX/issues/${gh_id}/comments" \
      > "Z${fn_id}_comments.json"
   curl -H "Authorization: token ${TOKEN}" \
      "https://api.github.com/repos/DMSTEX/DMSTEX/issues/${gh_id}/events" \
      > "Z${fn_id}_events.json"
   let gh_id=${gh_id}+1
done
