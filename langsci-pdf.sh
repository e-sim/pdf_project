#!/bin/bash

$PATH = "/projects/pdf_eval/data/langsci_books"
#as it is, must be run from this folder

for dir in */ ; do
    mkdir -p /home2/ejsim/pdf-proj/benchmark/pdf/$dir
    cd "/projects/pdf_eval/data/langsci_books/$dir"
    #echo $dir
    if [ -e "main.tex" ]; then 
        echo "main.tex found for $dir\n"
        /projects/pdf_eval/bin/pandoc --from=latex --pdf-engine xelatex -s main.tex -o \
        /home2/ejsim/pdf-proj/benchmark/pdf/$dir/$dir-main.pdf
    fi
    if [ -d "chapters" ]; then
        dir=${dir::-1} 
        #echo "chapters dir found for $dir"
        for file in ./chapters/*.tex ; do
            title=${file:11:-4}
            #echo "$title.txt"
            /projects/pdf_eval/bin/pandoc --from=latex --pdf-engine xelatex -s $file \
            -o /home2/ejsim/pdf-proj/benchmark/pdf/$dir/$dir-$title.pdf
        done
    fi

done

#/projects/pdf_eval/bin/pandoc --from=latex --to=plain -s 102/main.tex -o /home2/ejsim/langsci_txt/pdftestmain.txt