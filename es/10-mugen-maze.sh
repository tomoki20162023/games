#!/usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

es.mugen() {
	local i
	local d
	declare -a local diff_open=(70 0 -70)
	declare -a local diff_door=(70 70 -140)

	es.move.corner 1
	moving 80 240
	msleep 500

	for(( i=1; i<=${1:-2}; i++ ));
	do
		echo -ne "\t  : ${i} / ${1}\r"

		for(( d=0; d<3; d++ ));
		do
			_es.mugen-helper ${diff_open[${d}]} ${diff_door[${d}]}
		done
	done
	echo "Mugen finished."
}

_es.mugen-helper() {
	local to_open=${1}
	local to_next=$(( ${2} - ${1} ))

	clicks 2
	moving-click ${to_open} 260
	msleep 750
	click

	moving-click 0 -80
	moving-click 0 -50
	moving ${to_next} -130
	msleep 250
}
