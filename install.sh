#!/bin/bash

EXCLUDE=($0 README.md)

for fname in $(pwd)/*; do
	stripped_fname=`echo ${fname##*/}`

	exclude_this=0
	for exclude in ${EXCLUDE[@]}; do
		stripped_exclude=`echo ${exclude##*/}`
		if [ ${stripped_fname} = ${stripped_exclude} ]; then
			exclude_this=1
			break
		fi
	done
	if [ $exclude_this -eq 1 ]; then
		continue
	fi
	rm -rf ~/.${stripped_fname}
	ln -s ${fname} ~/.${stripped_fname}
done
