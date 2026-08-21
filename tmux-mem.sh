#!/bin/sh
# 状态栏右边那格可用内存。单独成脚本，不写在 .tmux.conf 里 ——
# tmux 会先解析 #() 内部的 #[ ] 和引号，awk 脚本塞进去必被咬碎（8-21 实测）。
avail=$(free -m 2>/dev/null | awk '/^Mem/{print $7}')
[ -z "$avail" ] && exit 0
g=$(awk -v m="$avail" 'BEGIN{printf "%.1f", m/1024}')
# 余量 <800M 时前面挂一颗点，提醒该关窗口了
if [ "$avail" -lt 800 ]; then printf '● %sG' "$g"; else printf '%sG' "$g"; fi
