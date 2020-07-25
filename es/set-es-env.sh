#! /usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

s=${1:-1}
if [ 1 -eq ${s} ]; then
	ESENV=1
elif [ 2 -eq ${s} ]; then
	ESENV=2
else
	echo "Eternal Scarlet Environment is set with 0."
	ESENV=0
fi
unset s

export ESENV

source common.sh
source xte_aliases.bash
source es.sh
source 10-mugen-maze.sh

source sample.sh
source sample2.sh

