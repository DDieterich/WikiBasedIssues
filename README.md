# WikiBasedIssues
Wiki Based (Distributed) Issue Tracking System for GitHub/GitLab

*NOTE:* Issues are tracked in the Wiki.  See: [Issues Summary](https://github.com/DDieterich/WikiBasedIssues/wiki/Z-Issues-Summary)


## Overview
This is a linux/GNU based set of scripts to accomplish to missions:
1. Create an Issues Summary Wiki Page for all Wiki Based Issues.
2. Capture Issues from GitHub and Translate them to Wiki Pages.

**Problem?**  GitHub (and GitLab) both have an Issues Repository and Wiki Pages.
With the source code in Git, we can clone the repository locally and
accomplish our work offline.  If we clone the Wiki for our Git Repository,
we can work on Wiki Pages while we are offline.  However, we can't update
any Issues while we are offline.

**Solution**  The existence of several projects that attempt to emulate
the offline capability of Git source code for Issues is an indicator this
functionality is needed.  The solution provided here is simple:
* Format Wiki Page names and content specifically for Issue Tracking.
* Each Issue has one, and only one, Wiki page.
* Generate a Summary Report Wiki Page to provide
    * An overview of all Issues.
    * A master list of all the issues being tracked.


## Example

Review the "wiki" for this repository to see examples of Wiki Based Issues.


## Installation

1. Clone the Wiki Repository.
1. Add [WikiBasedIssues](https://github.com/DDieterich/WikiBasedIssues)
   as a SubModule in a "WikiBasedIssues" folder at the root level
   of the (cloned) Wiki Repository.
1. Create Wiki Based Issues using Format listed below.
1. (optional) Download Issues from GitHub Repository
    * Open a BASH shell
    * "cd" to the root level of the (cloned) Wiki Repository.
    * Create "issues_download" folder.
    * cd to "issues_download" folder.
    * Run: "../WikiBasedIssues/github_issues_capture.sh" LAST_ID TOKEN
        * LAST_ID - Last Issue ID in the GitHub Repository.
        * TOKEN - Token used to access GitHub Repository.
        * (Creates 3 JSON files for each Issue.)
    * Install "py": `sudo apt install jq`
    * Run: "../WikiBasedIssues/github_json_to_md.sh"
        * (Converts JSON file data to Wiki Based Issues.)
1. To create the Issue Summary Report Wiki Page
    * Open a BASH shell
    * "cd" to the root level of the (cloned) Wiki Repository.
    * Run: "WikiBasedIssues/create_issues_summary.sh".
1. (One Time Only) Add `[Issues Summary](Z-Issues-Summary)` to Wiki Home Page.
1. Stage-Commit-Push the (cloned) Wiki Repository
1. Review results on GitHub Wiki
1. (optional) Add "pre-commit" trigger to Git client.
    * Comfirm you are working in the (cloned) Wiki Repository.
    * Follow installation instructions in comments of "WikiBasedIssues/pre-commit_trigger.sh" file.


## Wiki Based Issue Format

**Wiki Page Name Format:**
* "Z"
* 4 digit integer with leading zeros
* ".md"
* at the root level of the Wiki Repository.

*Example Wiki Page Name:* "Z0001.md"

**Wiki Page Content Format:**

See [Issue Template File](Z-Issue-Template.md)


## Parital Sample Summary Report

![Partial Example Summary Report](https://user-images.githubusercontent.com/12377020/178559307-b703acef-7b43-4a3f-8f0f-7ea45178f4ed.png)


## See Also
[RelDesGen Blog](https://www.reldesgen.com/2022/07/distributed-offline-issue-bug-tracker.html)


## File List

Filename                     | Description
-----------------------------|-------------
create_issues_summary.awk    | Creates the Z-Issues-Summary.md file
create_issues_summary.sh     | Runs the create_issues_summary.awk script
GitHub_Get_Issue_Schema.json | JSON Schema for Get Issue API at GitHub
github_issues_capture.sh     | Captures Issue Data from GitHub
github_json_to_md.sh         | Converts Captured Issue Data to Wiki Pages
LICENSE                      | Software License
pre-commit_trigger.sh        | Update Issue Summary File during Git Commit
Status-Descriptions.md       | Sample Status Values and Descriptions
sort_tmplog.awk              | Sort Utility for Issue Comments and Events
