#! /usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

declare -A es_menu

es_menu=(
	[bottom]="$(cat ./arglist/0/menu/bottom.args)"
	[left]="$(cat ./arglist/0/menu/left.args)"
	[right]="$(cat ./arglist/0/menu/right.args)"
	[oujou-bottom]="$(cat ./arglist/0/menu/oujou-bottom.args)"
)

es.menu.select() {
	if [ -z "${1}" -o -z "${2}" ]; then
		cat <<_EOT_
	usage: es.menu.select [menu-name] [menu-position]

	ex) es.menu.select bottom 2
_EOT_
		return 1
	fi

	ms=${1}
	num=${2}
	let num++

	case ${1} in
		l|left)
			ms=left
			;;
		r|right)
			ms=right
			;;
		b|bottom)
			ms=bottom
			;;
		ob|oujou|oujou-bottom)
			ms=oujou-bottom
			;;

		*)
			echo "Error 1st arg ..."
			return 2
			;;
	esac

	echo "${es_menu[${ms}]}" | head -n${num} | xargs xte
	xte "mouseclick 1" "sleep 1"
}

es.move.rel() {
	test -z "${1}" && echo "bad 1st arg ..." && return 1

	local i
	local cmd

	case ${1} in
		d|down)
			cmd="0 10"
			;;
		u|up)
			cmd="0 -10"
			;;
		l|left)
			cmd="-10 0"
			;;
		r|right)
			cmd="10 0"
			;;
		*)
			echo "bad 1st arg ..."
			return 2
			;;
	esac

	for(( i=0; i<${2:-1}; i++ ));
	do
		xte "mousermove ${cmd}" "usleep 100000"
	done
}

es.act.attack-boss() {
	es.move.center
	xte "mousermove 0 180"
	click

	# hihyouzi
	moving-click -130 -80
}

es.act.adjust() {
	case ${ESENV} in
		1)
			xte 'mousemove 50 1000'
			;;
		2)
			xte 'mousemove 50 710'
			;;
		*)
			echo "no scrollbar adjusted."
			return 2
			;;
	esac

	drag 103 0
}

es.oujou.tougijou() {
	local c

	es.move.corner 4
	moving -130 -170
	msleep 300

	for(( c=1; c<=${1:-1}; c++ ));
	do
		printf "%3d / %3d\r" ${c} ${1}
		moving-click-alt 50 -20 250
	done

	es.back
}

es.guild.maze() {
	local attacks=${1:-18}
	local i

	es.move.center
	moving 0 80

	for(( i=1; i<=${attacks}; i++ ));
	do
		printf "  : %2d / %2d\r" ${i} ${attacks}
		moving-click 0 80
		moving 0 -80
		countdown 4
		click
	done
}

es.guild.nikkatsu() {
	local skip=${1:-0}

	_es.nikkatsu 135 90 ${skip}

	es.back
}

es.daily.completed() {
	local i
	local n=${1:-1}

	echo -ne "0 / ${n}\r"
	for i in $(seq 1 ${n});
	do
		echo -ne "${i} / ${n}\r"
		es.move.corner 3

		moving-click -40 160
		moving-click -90 180
	done
}

es.daily.nikkatsu() {
	local skip=${1:-0}

	_es.nikkatsu 150 140 ${skip}

	moving-click -10 -280
	moving 0 430
}

_es.nikkatsu() {
	local xs0=( -20 10 40 70 130 )
	local initx=${1}
	local confirm=${2}
	local skip=${3:-0}
	local i

	es.move.corner 2
	moving ${initx} -200

	for(( i=0; i<5; i++ ));
	do
		if [ ! ${i} -lt ${skip} ]; then
			moving-click-alt ${xs0[${i}]} ${confirm}
		fi
	done
}

es.act.magic-research() {
	local t
	local c
	for(( c=0; c<4; c++ ));
	do
		es.move.corner 4
		moving -60 -60

		clicks ${1:-1}
		msleep 200

		es.move.corner 1
		let t="1 + ( 1 + ${c} ) % 4"
		case ${t} in
			1)
				moving-click 90 50
				;;
			2)
				moving-click 130 50
				;;
			3)
				moving-click 170 50
				;;
			4)
				moving-click 210 50
				;;
			*)
				echo "bad arg ..."
				return 2
				;;
		esac
	done
}

es.act.exp-tower-next() {
	moving-click-alt -30 90
}

es.first.actions() {
	es.item.clear
	sleep 1
	es.first.shop
	sleep 1
	es.first.maid-cafe
	sleep 1
	es.first.maze
	sleep 1
	es.first.chat
}

es.first.shop() {
	es.menu.select bottom 7
	sleep 1

	moving-click -230 -360
	msleep 500

	moving-click 20 150
	moving-click 50 90
	moving-click 70 -80
	moving-click -20 30

	es.back
	msleep 500
	es.back
}
es.first.maid-cafe() {
	es.act.check-maid-cafe 1st
# ???	moving-click 85 -200
}
es.first.chat() {
	es.move.corner 4
	moving-click -15 -60
	moving-click -170 40
	moving-click 0 -40

	xte "str 1" "usleep 100000"

	es.act.adjust

	es.move.corner 4
	moving-click -85 -60
	moving-click 70 -250
}
es.first.maze() {
	local y

	es.menu.select left 3
	sleep 1

	moving-click 140 -170
	msleep 500
	moving 100 101

	for(( y=-36; y<=276; y+=78 ));
	do
		moving-click-alt -10 ${y}
	done

	es.back
}

es.act.check-maid-cafe() {
	es.menu.select bottom 5
	sleep 1

	moving 0 -50
	drag 0 -120
	moving-click 0 -20

	moving-click -100 30
	moving-click 20 -130

	if [ ! -z "${1}" ]; then
		moving-click 70 130
		moving-click -10 -70
		moving-click 0 -100
		moving-click 85 -200
	fi

	es.back
	msleep 300
	es.back
}

es.act.mail-kaisyu() {
	es.menu.select r 2
	msleep 300

	es.move.corner 2
	moving-click 150 -50
	moving-click 0 -150
	clicks 2
}

es.hubun.setting() {
# position : $1
	es.hubun.position ${1}
	click

	case ${2:-0} in
		1)
	# 合成のケース
	es.move.center
	moving-click 0 100
	moving-click 0 20
	moving-click 0 -160
	# soutou
	moving-click 0 180
	# confirm
	moving-click 30 -70
	msleep 500
			;;
		2)
	# 獲得のケース
	es.move.center
	moving-click 0 100
	moving-click 0 -140
	# soutou
	moving-click 0 180
	# confirm
	moving-click 30 -70
	msleep 500
			;;
		*)
			echo "Error : bad arg ..."
			return 2
			;;
	esac

	# back
	moving-click 80 -170
	moving-click 0 10
	moving-click 0 -70

	# 一括装着
	es.move.center
	moving-click 0 180
}
es.tab5.select() {
# y: $1, num: $2
	local x=30
	local y=${1}
	local dx=60
	local dy=0
	local n=${2:-0}
	es.tabs.select ${x} ${y} ${dx} ${dy} ${n}
}
es.tab3.select() {
# y: $1, num: $2
	local y=${1}
	local x=90
	local dx=60
	local dy=0
	local n=${2:-0}
	es.tabs.select ${x} ${y} ${dx} ${dy} ${n}
}
es.tabs.select() {
# x: $1, y: $2, dx: $3, dy: $4, num: $5, max: $6
	local x=${1}
	local y=${2}
	local dx=${3}
	local dy=${4}
	local n=${5}
	local nmax=${6}
	local i

	for(( i=0; i<${n}; i++ ));
	do
		let "x += dx"
		let "y += dy"
	done

	moving-click ${x} ${y}
}

es.shop.select() {
# num: $1
	es.move.center
	moving 0 -20

	case ${1} in
		0) # Pet Shop
			click
			;;
		1) # Misc Shop
			moving-click -90 -110
			;;
		2) # Mistery Shop
			moving-click 90 -110
			;;
		3) # Today Only
			moving-click -90 110
			;;
		4) # Arena Shop
			moving-click 90 110
			;;
		*)
			echo "Error arg ..."
			return 2
			;;
			
	esac
}

es.character.select() {
# num : $1
	local y=50
	local x=90
	local i

	es.move.corner 1
	for(( i=0; i<${1}; i++ ));
	do
		x=$(( x+40 ))
	done
	moving-click ${x} ${y}
	msleep 300
}

es.tab.char.select() {
	es.move.corner 2
	es.tab5.select -90 ${1}
}
es.tab.equip.select() {
	es.move.corner 1
	es.tab5.select 110 ${1}
}
es.guild.select-ninmu() {
	es.move.center
	case ${1} in
		0) # guild-maze
			moving-click -70 0
			;;
		1) # boss
			moving-click 70 0
			;;
		2) # guild work
			moving-click -70 90
			;;
		3) # guild kifu
			moving-click 70 90
			;;
		*) # error
			echo "Error bad arg ..."
			return 2
			;;
	esac
}

es.act.syougou-kyouka() {
	es.move.corner 1
	es.tab3.select 55 1
	es.move.center
	moving-click 70 0
# kyouka
	es.move.center
	moving-click 0 220
	msleep 300
	es.back
}
es.act.syoutai-hyouka() {
	es.move.corner 2
	moving-click 40 -50

# wairo select
	es.move.center
	case ${1:-1} in
		1) # beer
			moving-click 50 -60
			moving-click -20 190
			;;
		2) # wine
			moving-click 50 0
			moving-click -20 130
			;;
		*)
			echo "Error : bad arg ..."
			return 2
			;;
	esac

	moving-click 80 -240
	msleep 300
	es.back
}

es.guild.kifu.first() {
	es.menu.select ob 2
	sleep 5
	es.guild.select-ninmu 3
	es.guild.kifu.10 first
}

es.stage.switch() {
	es.move.corner 4
	moving-click -30 -80
}
es.stage.item.clear() {
	es.stage.switch
	msleep 500
	es.item.clear
	es.stage.switch
}

es.pk() {
	local n=${1:-1}
	local i

	es.move.corner 1
	moving-click 23 194
	moving 150 170

	for(( i=1; i<=${n}; i++ ));
	do
		printf "  : %2d / %2d\r" ${i} ${n}
		es.pk.once ${2}
		countdown 4
	done
}

es.event.roulet() {
	es.move.center
	moving-click 0 -60
	moving 0 130
	sleep 5

	click
	moving 0 -70
	msleep 300
}
es.event.roulets() {
	local n=${1:-1}
	local i

	for(( i=1; i<=n; i++ ));
	do
		printf "%2d / %2d\r" ${i} ${n}
		es.event.roulet
	done
}

es.hubun.check() {
	es.hubun.position ${1:-1}
	click
	es.move.corner 3
	moving-click -40 120
}

es.act.kinka-shiren() {
	es.move.center
	moving-click 0 80
	moving-click 0 140
	moving 100 -300
}

es.daily.housyuh() {
# research position only
	moving 62 64 # 1-block ???
}

es.guild.kifu.housyu() {
	local x=-30
	local dx=65
	local i

	es.move.corner 2
	moving 170 -190

	for(( i=0; i<3; i++ ));
	do
		_es.guild.kifu.housyu ${x}
		let "x += dx"
	done
}
_es.guild.kifu.housyu() {
	local negx=$(( -${1} ))
	moving-click ${1} 140
	moving-click ${negx} -160
	moving-click 0 20
}

es.act.weekly.diamond-kaisyu() {
	es.move.center
	moving 30 70

	moving-click-alt 40 -65
}

