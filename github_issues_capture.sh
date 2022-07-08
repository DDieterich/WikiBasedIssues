#!/bin/bash

#  Run using: ../WikiBasedIssues/github_issues_capture.sh
#  in an empty folder that is that is under the Wiki root folder.

# Requires the ID of the last Issue in the repository
#  Optionally, provide a value for lAST_ID as 1st Command line Parameter.
if [ ! -z "${1}" ]
then
   LAST_ID="${1}"
fi
if [ -z "${LAST_ID}" ]
then
   echo "No value for LAST_ID"
   exit -2
fi
echo "Using LAST_ID ${LAST_ID}"

# Requires a "TOKEN" to read the issues reqository.
#  Optionally, provide a value for TOKEN as 2nd Command line Parameter.
if [ ! -z "${2}" ]
then
   TOKEN="${2}"
fi
if [ -z "${TOKEN}" ]
then
   echo "No value for TOKEN"
   exit -1
fi
echo "Using TOKEN ${TOKEN}"

gh_id=1
while [ ${gh_id} -le "${LAST_ID}" ]
do
   echo ""
   printf -v fn_id "%04i" ${gh_id}
   echo "Collecting GitHub ID: ${gh_id}, Filename ID: ${fn_id}"
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
