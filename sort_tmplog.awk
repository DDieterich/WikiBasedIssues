
BEGIN {
   PROCINFO["sorted_in"] = "@ind_str_desc";
   FS = "\v";
   RS = "\f";
   }

// {
   f2[$1]=$2;
   f3[$1]=$3;
   }

END {
   for (f1 in f2) {
      print f1 f2[f1] f3[f1];
      }
   }
