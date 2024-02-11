#!/bin/bash

section_builder () {
	out=$(jq -r -f ./$format/$1.jq --arg tag $tag $resumefile | paste -s -d ";" | sed "s|;|\\\n|g; s|&|\\\&|g")
	sed -i "s|{.$1}|$out|g" $outfile
}

resume_builder () {
	resumefile="../resume.json"
	infile="../templates/resume.$format"
	outfile="../out/${tag^}_Resume.$format"
	fields=( "basics" "work" "volunteer" "education" "projects" "skills" "languages" "interests" "publications" "research" "courses" "certifications" )

	cp $infile $outfile
	for f in "${fields[@]}"
	do
		section_builder $f
		echo "built $format $f section in $outfile"
	done
	sed -i 's|\*: \*||g; /^$/N; /^\n$/D' $outfile

	if [ $format == "md" ]
	then
	cd ../out
	pandoc $outfile -o "${tag^}_Resume.docx"
	cd -
	else
	cd ../out
	sed -i ' s|&|\\&|g; s|{aozora_corpus}|{aozora{\\_}corpus}|g' $outfile
	xelatex $outfile
	cd -
	fi 
}

output_resumes () {
	format="md"
	resume_builder
	format="tex"
	resume_builder
}

echo -n "tag name [*full*|data|japanese|cv|all]: "
read -r tag
tag="${tag:=full}"

if [ $tag == "all" ]
then
tag="full"
output_resumes
tag="data"
output_resumes
tag="japanese"
output_resumes
tag="cv"
output_resumes
else
output_resumes
fi
