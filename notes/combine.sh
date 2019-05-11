#!/usr/bin/env bash
# Author: "abpwrs"
# Date: 20190423

# script:

# generate pdfs for every chapter
./ipynb-2-pdf.sh

# remove old notes
rm notes.pdf
rm README.md

# update title slide
pandoc 00.md -o 00.pdf

# combine all sub pdfs
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=notes.pdf *.pdf

# delete the generated pdfs
for pyfi in ./*.ipynb; do
	rm $(basename $pyfi .ipynb).pdf
done

# generate a new README.md of the notes
./ipynb-2-README.sh


