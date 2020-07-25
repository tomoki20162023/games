#! /usr/bin/env bash
# -*- utf8 -*-
## eternal scarlet
## zoom : 67%
## width : 302 px
## height : 533 px

## shellでcommon.shを読み込んで使うか
## このファイルに取り込むこと

## ES用関数
es.move.corner() {
	local L=88
	local R=390
	local T=137
	local B=670
	case ${1:-1} in
		1) xte "mousemove ${L} ${T}" ;;
		2) xte "mousemove ${L} ${B}" ;;
		3) xte "mousemove ${R} ${T}" ;;
		4) xte "mousemove ${R} ${B}" ;;
		*)
			echo "bad arg ..."
			return 2
			;;
	esac
}

es.move.center() {
	xte "mousemove 239 403"
}

es.game.start() {
	if [ -z "${2}" ]; then
		es.move.corner 2
		moving-click 50 -100 #HD版クリック
		countdown 5
	fi

	es.move.center
	moving-click 120 110 # サーバ選択開く
	moving-click 0 -150 # サーバグループ選択
	case ${1:-0} in
		1)
			moving 60 157
			drag 0 -250
			drag 0 -250
			click # s1 選択
			;;
		15)
			moving-click 60  95 # s15 選択
			;;
		19)
			moving-click 60 -29 # s19 選択
			;;
		20)
			moving-click 60 -60 # s20 選択
			;;
		*)
			echo "no matched..."
			return 2
			;;
	esac

	es.move.corner 4
	moving-click 0 -90

	countdown 3
	es.act.adjust
	msleep 500
	es.move.center
	moving-click 0 120 # 開始時確認ボタン
}

es.change-5tabs() {
	local i
	local x=30
	local y=60
	local dx=60

	es.move.corner 1
	for(( i=1; i<${1:-1}; i++ ));
	do
		let "x += dx"
	done
	xte "mousermove ${x} ${y}"
	click
}

es.guild.kifu.10() {
	es.move.center
	moving-click 80 40

	if [ ! -z "${1}" ]; then
		moving-click 0 -35
		moving-click 0 30
	fi
}
es.guild.kifu.300() {
	moving-click -70 0
	moving-click 70 120
	moving 0 -120
}

es.hubun.position() {
# 上から時計回りに1 - 6とする
	es.move.center
	case ${1} in
		1)
			moving 0 -100 # 上
			;;
		2)
			moving 90 -40 # 右上
			;;
		3)
			moving 90 50 # 右下
			;;
		4)
			moving 0 100 # 下
			;;
		5)
			moving -90 50 # 左下
			;;
		6)
			moving -90 -40 # 左上
			;;
		*)
			echo "no matched..."
			;;
	esac
}

es.back() {
	es.move.corner 1
	moving-click 20 20
}

es.pk.once() {
	click
	if [ -z "${1}" ]; then
		moving-click-alt 40 -65
	else
		moving-click -10 -310
		moving-click 0 440
	fi
}

es.item.clear() {
	local i

	es.menu.select b 6
	msleep 300

	moving-click 0 -80
	moving-click -110 -35
	moving 110 0

	_es.decomposition
	click
	msleep 300
	es.back
}
	
_es.decomposition() {
	xte "mousemove 328 530"
	for(( i=0; i<5; i++ ));
	do
		moving-click 0 -47
	done
	moving-click 30 -50
	msleep 300
}

es.item.get() {
	local i
	local n=${1:-1}

	echo -ne "0 / ${n}\r"
	for i in $(seq 1 ${n});
	do
		echo -ne "${i} / ${n}\r"
		es.move.corner 1
		moving-click 40 100
		moving-click 113 300
		moving-click 0 -50
#		moving -140 -350
	done
}

es.kirei.clear() {
	es.move.corner 2
	moving-click 50 -110
	moving 190 -30
	# 328 530
	_es.decomposition
}

es.act.johju() {
	es.move.corner 3
	moving-click -17 309
	moving-click -130 190
	es.back
}


