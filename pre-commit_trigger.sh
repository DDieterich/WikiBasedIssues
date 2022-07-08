#!/bin/bash

# Hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.

# 1) Create folder ".githooks" at Wiki repository root level
# 2) Copy this file to ".githooks/pre-commit"
# 3) Use this command to move the git hook location:
#    git config core.hooksPath .githooks

function show_error () {
   echo "To avoid this pre-commit trigger, run 'git commit' with '--no-verify'."
   echo "Aborting Commit..."
   }

# Ensure Summary File has been updated after last issue page update.
summfile="Z-Issues-Summary.md"
lastfile=`ls -t Z[0-9][0-9][0-9][0-9].md | head -1`
lastdate=`date -r "${lastfile}" "+%Y%m%d%H%M%S"`
summdate=`date -r "${summfile}" "+%Y%m%d%H%M%S"`
if [ "${lastdate}" -ge "${summdate}" ]
then
   echo "lastdate (${lastdate}) is greater than or equal to summdate (${summdate})"
   echo "Updating ${summfile}..."
   "WikiBasedIssues/create_issues_summary.sh"
   retcd="${?}"
   if [ "${retcd}" != "0" ]
   then
      echo "Update of ${summfile} failed, returned ${retcd}"
      show_error
      exit "${retcd}"
   fi
   echo "Staging Updated ${summfile}..."
   git stage "${summfile}"
   retcd="${?}"
   if [ "${retcd}" != "0" ]
   then
      echo "Staging of updated of ${summfile} failed, returned ${retcd}"
      show_error
      exit "${retcd}"
   fi
   echo "${summfile} Updated and Staged."
else
   echo "Confirmed: lastdate (${lastdate}) is less than summdate (${summdate})"
fi

exit 0
