p2_keywords_alignments=(XXXXXXXX)
for keyword in ${p2_keywords_alignments[@]}
do
  val=$(grep -i $keyword README.problem2.txt)
  echo {${#val}}
done
