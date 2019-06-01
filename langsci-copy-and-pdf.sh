#!/bin/bash

$PATH = "/projects/pdf_eval/data/langsci_books"
#as it is, must be run from this folder

#TODO  clean up, use variables for all paths

for dir in */ ; do
    mkdir -p /home2/ejsim/pdf-proj/benchmark/pdf/$dir
    cd "/projects/pdf_eval/data/langsci_books/$dir"
    #echo $dir
    if [ -e "main.tex" ]; then 
        echo "main.tex found for $dir\n"
        #i'm guessing i need an if then thing here to only copy it if pandoc runs successfully
        if /projects/pdf_eval/bin/pandoc --from=latex -s main.tex -o \
        /home2/ejsim/pdf-proj/benchmark/pdf/$dir/$dir-main.pdf; then
            cp main.tex /home2/ejsim/pdf-proj/benchmark/src/$dir/$dir-main.tex
        fi
    fi
    if [ -d "chapters" ]; then
        dir=${dir::-1} 
        #echo "chapters dir found for $dir"
        for file in ./chapters/*.tex ; do
            title=${file:11:-4}
            #echo "$title.txt"
            if /projects/pdf_eval/bin/pandoc --from=latex -s $file \
            -o /home2/ejsim/pdf-proj/benchmark/pdf/$dir/$dir-$title.pdf; then
                cp $file /home2/ejsim/pdf-proj/benchmark/src/$dir/$dir-$file.tex
            fi
        done
    fi

done

#/projects/pdf_eval/bin/pandoc --from=latex --to=plain -s 102/main.tex -o /home2/ejsim/langsci_txt/pdftestmain.txt