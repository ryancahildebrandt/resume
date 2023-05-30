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
	cp ../templates/deedy-resume.cls ./
	cp ../templates/deedy-resume_sm.cls ./
	xelatex $outfile
	rm deedy-resume.cls
	rm deedy-resume_sm.cls
	cd -
	fi 
}

echo -n "tag name [*full*|data|japanese|cv]: "
read -r tag
tag="${tag:=full}"

format="md"
resume_builder
format="tex"
resume_builder

