#!/bin/bash
word="akjdklajfkalsj"
#$(python -c "import print_lines; print print_lines.print_lines()") >> results.txt

result=$(grep ${word[@]} results.txt)
res_length=${#result}

if [ ${#result} -eq 0 ]
then
  echo "uh oh"
fi
