#! /usr/bin/env bash
# -*- utf8 -*-

## 基本的な関数
countdown() {
	local t
	for t in $(seq ${1:-1} -1 1);
	do
		echo -ne "$t\r"
		sleep 1
	done
	echo -ne "0\r"
}

delta-moving() {
# x: $1, y: $2, delta: $3 > 0
	local nx=0
	local ny=0
	local d=${3:-1}
	local nxe
	local nye
	local dx
	local dy

	if [ ${d} -lt 0 ]; then
		${d}=-${d}
	elif [ ${d} -eq 0 ]; then
		${d}=1
	fi

	let "nxe = ${1} / ${d}"
	let "nye = ${2} / ${d}"

	if [ ${1} -lt 0 ]; then
		dx=-${d}
		let "nxe=-nxe"
	else
		dx=${d}
	fi
	if [ ${2} -lt 0 ]; then
		dy=-${d}
		let "nye=-nye"
	else
		dy=${d}
	fi

	while [ $nx -lt $nxe -a $ny -lt $nye ];
	do
		let nx++
		let ny++
		xte "mousermove ${dx} ${dy}" "usleep 50000"
	done

	while [ $nx -lt $nxe ];
	do
		let nx++
		xte "mousermove ${dx} 0" "usleep 50000"
	done

	while [ $ny -lt $nye ];
	do
		let ny++
		xte "mousermove 0 ${dy}" "usleep 50000"
	done
}

moving() {
# x: $1, y: $2
# 2, 11, 56
# 3, 16, 81
# 3, 13, 66
# 4, 17, 69
	local x=${1:-0}
	local y=${2:-0}
	local delta=66
	delta-moving ${x} ${y} ${delta}

	let "x %= ${delta}"
	let "y %= ${delta}"
	delta=13
	delta-moving ${x} ${y} ${delta}

	let "x %= ${delta}"
	let "y %= ${delta}"
	delta=3
	delta-moving ${x} ${y} ${delta}

	let "x %= ${delta}"
	let "y %= ${delta}"
	xte "mousermove ${x} ${y}" "usleep 200000"
}

moving-click() {
	moving ${1} ${2}
	xte "mouseclick 1" "usleep 300000"
}
moving-click-alt() {
	local xo=$(( -${1} ))
	local yo=$(( -${2} ))
	local wt=${3:-0}
	moving-click ${1} ${2}
	if [ ${wt} -gt 0 ]; then
		msleep ${wt}
	fi
	moving-click ${xo} ${yo}
}

drag() {
	xte "mousedown 1" "usleep 200000"
	moving ${1} ${2}
	xte "mouseup 1" "usleep 200000"
	moving $(( -${1} )) $(( -${2} ))
}

msleep() {
	xte "usleep ${1:-1}000"
}

clicks() {
	local n=${1:-4}
	local i
	for(( i=1; i<=${n}; i++ ));
	do
		printf "%3d / %3d\r" ${i} ${n}
		xte "mouseclick 1" "usleep 250000"
	done
}

