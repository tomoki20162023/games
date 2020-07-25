#! /usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

if [ -z "${1}" -o ! -f ${1} ]; then return 1; fi

cat ${1} | grep -ve 'click' > ./0/${1}

