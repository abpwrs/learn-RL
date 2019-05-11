#!/usr/bin/env bash
# Author: "abpwrs"
# Date: 20190423

# script:
for pyfi in ./*.ipynb; do
	jupyter nbconvert --to pdf $pyfi
done

