
BEGIN {
   PROCINFO["sorted_in"] = "@ind_str_desc";
   IGNORECASE = 1;  # Ignore Case in Search Strings
   RS = "\r?\n";    # Allow for MS-Windows Line Endings
   }

/^FILENAME  [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   gsub(/[.]md/, "", $0);
   fn = $0;
   dm[fn] = "(null D)";
   tt[fn] = "(null T)";
   st[fn] = "(null S)";
   as[fn] = "(null A)";
   ms[fn] = "(null M)";
   #eh[fn] = "(0E)";
   #pc[fn] = "(0P)";
   #lb[fn] = "(null L)";
   next;
   }

/^Modified  [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      dm[fn] = $0;
      }
   next;
   }

/^Issue     [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      tt[fn] = $0;
      }
   next;
   }

/^Status    [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      st[fn] = $0;
      }
   stc[st[fn]] += 1;
   next;
   }

/^Assigned  [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      as[fn] = $0;
      }
   asc[as[fn]] += 1;
   next;
   }

/^Milestone [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      ms[fn] = $0;
      }
   msc[ms[fn]] += 1;
   next;
   }

/^Est Hrs   [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      eh[fn] = $0;
      }
   next;
   }

/^[%]Complete [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      pc[fn] = $0;
      }
   next;
   }

/^Label     [|]/ {
   $0 = substr($0, 12);
   gsub(/^[ \t]+|[ \t]+$/, "", $0);
   if (length($0) > 0) {
      lb[fn] = $0;
      }
   lbc[lb[fn]] += 1;
   next;
   }

END {
   print "## Statuses";
   tot = 0;
   for (sti in stc) {
      print "* **" sti "** - " stc[sti];
      tot += stc[sti];
      }
   print "";
   print "**Total Statuses:** " tot;
   print "";

   print "## Assignments";
   tot = 0;
   for (asi in asc) {
      print "* **" asi "** - " asc[asi];
      tot += asc[asi];
      }
   print "";
   print "**Total Assignments:** " tot;
   print "";

   print "## Milestones";
   tot = 0;
   for (msi in msc) {
      print "* **" msi "** - " msc[msi];
      tot += msc[msi];
      }
   print "";
   print "**Total Milestones:** " tot;
   print "";

   print "## Labels";
   tot = 0;
   for (lbi in lbc) {
      print "* **" lbi "** - " lbc[lbi];
      tot += lbc[lbi];
      }
   print "";
   print "**Total Labels:** " tot;
   print "";

   lt = 0;
   for (sti in stc) {
      print "## " sti " Issues";
      ln=0;
      for (fn in tt) {
         if (st[fn] == sti) {
            lt += 1;
            ln += 1;
            if ( ln % 10 == 1 ) {
               print "";
               print "Page Name         | Last Modified     | Assigned       | Milestone | Est | Pct | Label     | Title";
               print "------------------|-------------------|----------------|-----------|-----|-----|-----------|-------";
            }
            printf   "%-18s", "[" fn ".md](" fn ")";
            printf "| %-18s", dm[fn];
            printf "| %-15s", as[fn];
            printf "| %-10s", ms[fn];
            printf "| %-4s",  eh[fn];
            printf "| %-4s",  pc[fn];
            printf "| %-10s", lb[fn];
            printf "| %s\n",  tt[fn];
            }
         }
      print ""
      print "**Total " sti " Issues:** " ln;
      print ""
      }
   print ""
   print "**Grand Total Issues:** " lt;
   print ""
   }
