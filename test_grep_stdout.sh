result=$(python -c "import print_lines; print_lines.print_lines()" | grep -i "hello")
echo $(python -c "import print_lines; print_lines.print_lines()") >> "result.txt"
echo $' ' >> result.txt

echo ${result}
