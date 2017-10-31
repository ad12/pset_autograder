#!/bin/bash
pset_directory="PS4"

# README filename constants
p2_readme="README.problem2.txt"

# README keywords constants
p2_keywords=()

# list of submissions that are missing keywords in README
p2_wrong_netids=()


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

## Check $found_word to see if the keyword was found in file
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

# call this function to check problem 2
# $1 will the the netid of the student
check_p2()
{
  # Boolean tracking if student is missing information
  # If 0, not missing any information; else, missing information
  local netid=$1
  local missing_information=0

  echo $(python -c "import GlobalAligner; GlobalAligner.solve_global_aligner()") >> "p2_result.txt"
  echo $' ' >> "p2_result.txt"

  for keyword in ${p2_keywords[@]}
  do
    # Check README file
    read_file $p2_readme $keyword
    if [ $found_word -eq 0 ]
    then
      $missing_information=1
    fi

    # Check result file
    read_file "p2_result.txt" $keyword
    if [ $found_word -eq 0 ]
    then
      $missing_information=1
    fi
  done

  # if missing_information > 0, this user is missing information
  if [ $missing_information -gt 0]
  then
    p2_wrong_netids+=(${netid})
  fi
}


# Start main execution
latest_submissions=($(python -c "import get_latest_submissions; print get_latest_submissions.get_latest_submissions('PS3')" | tr -d '[],'))

for netid in ${latest_submissions[@]}
do
  # go to sub directory
  go_to_sub_directory ${netid}

  # Check README and print statements for keywords
  check_p2 ${netid}

  # jump back to main directory
  go_to_main_directory
done

echo ${p2_wrong_netids[@]}
