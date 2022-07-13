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
   while read FILE
   do
      echo "FILENAME  | ${FILE}"
      #if [ -z `git diff --name-only HEAD -- "./${FILE}"` ]
      #then
      #   # This file has not changed.  Use the date/time of the last commit.
      #   echo "Modified  | "`git log -1 --pretty="format:%cd" --date="format:%Y%m%d %H%M %z" "./${FILE}"`
      #else
      #   # This file has uncommitted changes.  Use the file system date/time.
      #   echo "Modified  | "`date -r "./${FILE}" "+%Y%m%d %H%M %z"`
      #fi
      head -10 "${FILE}"
   done |
   awk -f "${awkfile}" \
      > "${summfile}"
