#!/bin/bash
pset_directory="PS3"
failed_local_aligner=()

p1_readme="README.problem1.txt"
p2_readme="README.problem2.txt"
p3_readme="README.problem3.txt"
p4_readme="README.problem4.txt"
p5_readme="README.problem5.txt"

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

latest_submissions=($(python -c "import get_latest_submissions; print get_latest_submissions.get_latest_submissions('PS3')" | tr -d '[],'))

for netid in ${latest_submissions[@]}
do
  go_to_sub_directory ${netid}

  # Read README



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
