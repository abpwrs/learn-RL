#!/usr/bin/env bash
# Author: "abpwrs"
# Date: 20190511

# script:


for pyfi in ./*.ipynb; do
	jupyter nbconvert --to markdown $pyfi
done

pandoc *.md -o README.md

for pyfi in ./*.ipynb; do
	rm $(basename $pyfi .ipynb).md
done



