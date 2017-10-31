#!/bin/bash
pset_directory="PS3"
failed_local_aligner=()

go_to_main_directory()
{
  cd ../..
}

go_to_sub_directory()
{
  # $1 is netid unprocessed
  local netid=$1
  local netid_stripped="${netid:1:${#netid}-2}";
  local sub_path=$(printf "%s/%s" "${pset_directory}" "${netid_stripped}")
  cd $sub_path
}

test_local_aligner
{
  local solutions="";
  local student_solution=$(python -c 'import LocalAlignerPlus; print LocalAlignerPlus.solve_local_aligner_plus()')

  solution_matches=0;
  for solution in ${solutions[@]}
  do
    if (solution == student_solution)
    then
      $solution_matches=1
      break;
    fi
  done

  if ($solution_matches==0)
  then

  fi
}

latest_submissions=($(python -c "import get_latest_submissions; print get_latest_submissions.get_latest_submissions('PS3')" | tr -d '[],'))

for netid in ${latest_submissions[@]}
do
  go_to_sub_directory ${netid}

  # TEST CODE


  go_to_main_directory
done


# file_name=$(printf "PS3/%s" "${latest_submissions[0]}")
# file_name2="${latest_submissions[0]:1:${#latest_submissions[0]}-2}"
# echo $file_name2
# cd $file_name
# alpha=3
# cd sub_folder2
# p=$(printf "import test; print test.get_foo(%i)" "$alpha")
# RESULT=$(python -c "${p[*]}")
# cd ..
#
# echo $RESULT
#
# unset RESULT
