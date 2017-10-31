#!/bin/bash
pset_directory="PS3"
failed_local_aligner=()

# README filename constants
p2_readme="README.problem2.txt"
p3_readme="README.problem3.txt"
p4_readme="README.problem4.txt"
p5_readme="README.problem5.txt"

# Python files by program
p5_py_file="LocalAlignerPlus"
# README keywords constants
p1_keywords=()
p2_keywords=()
p3_keywords=()
p4_keywords=()
p5_keywords=()

# list of submissions that are missing keywords in README
p1_wrong_netids=()
p2_wrong_netids=()
p3_wrong_netids=()
p4_wrong_netids=()
p5_wrong_netids=()


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

save_local_aligner_result()
{
  local solutions="";
  local student_solution=$(python -c 'import LocalAlignerPlus; LocalAlignerPlus.solve_local_aligner_plus()')

}

## Check $found_word to see if the keyword was found
##
read_file()
{
  found_word=1
  local filename=$1
  local keyword=$2

  local grep_result=$(grep ${keyword[@]} ${filename[@]})

  if [ ${#grep_result} -eq 0 ]
  then
    $found_word=0
}

check_p4()
{
  # Boolean tracking if student is missing information
  # If 0, not missing any information; else, missing information
  local netid=$1
  local missing_information=0

  # Read p5 README
  for keyword in ${p4_keywords[@]}
  do
    read_file $p4_readme $keyword

    if [ $found_word -eq 0 ]
    then
      $missing_information=1
    fi
  done

  if [ $missing_information -gt 0]
  then
    p4_wrong_netids+=(${netid})
  fi
}

read_p5_readme()
{
  # Boolean tracking if student is missing information
  # If 0, not missing any information; else, missing information
  local netid=$1
  local missing_information=0

  # Read p5 README
  for keyword in ${p5_keywords[@]}
  do
    read_file $p5_readme $keyword
    local keyword_in_printed_output=$(python -c "import LocalAlignerPlus; LocalAlignerPlus.solve_local_aligner_plus()" | grep -i $keyword)
    if [ $found_word -eq 0 ]
    then
      $missing_information=1
    fi
  done

  if [ $missing_information -gt 0]
  then
    p5_wrong_netids+=(${netid})
  fi
}


# Start main execution
latest_submissions=($(python -c "import get_latest_submissions; print get_latest_submissions.get_latest_submissions('PS3')" | tr -d '[],'))

for netid in ${latest_submissions[@]}
do
  # go to sub directory
  go_to_sub_directory ${netid}

  # Check README for keywords
  read_p4_readme ${netid}
  read_p5_readme ${netid}

  # jump back to main directory
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
