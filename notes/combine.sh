#!/usr/bin/env bash
# Author: "abpwrs"
# Date: 20190423

# script:
./ipynb-2-pdf.sh
rm notes.pdf
pandoc 00.md -o 00.pdf
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=notes.pdf *.pdf

for pyfi in ./*.ipynb; do
	rm $(basename $pyfi .ipynb).pdf
done
