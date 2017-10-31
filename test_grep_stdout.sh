result=$(python -c "import print_lines; print_lines.print_lines()" | grep -i "hello")

echo ${result}
