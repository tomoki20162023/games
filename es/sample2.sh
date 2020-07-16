#! /usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

es.go.mugen() {
	es.move.center
	moving-click 0 40
}

es.stage.get-bonus() {
	local n=${1:-1}
	local i
	for(( i=0; i<${n}; i++ ))
	do
		es.menu.select left 7
		msleep 500
	done
}

