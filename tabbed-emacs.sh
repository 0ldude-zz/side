#!/bin/sh
#
# See the LICENSE file for copyright and license details. 
#

xidfile="$HOME/tmp/tabbed-emacs.xid"
uri="emacs"

if [ "$#" -gt 0 ];
then
	uri="$1"
fi

runtabbed() {
	tabbed -dn tabbed-emacs -r 2 st -w ''  -e $uri >"$xidfile" \
		2>/dev/null &
}

if [ ! -r "$xidfile" ];
then
	runtabbed
else
	xid=$(cat "$xidfile")
	xprop -id "$xid" >/dev/null 2>&1
	if [ $? -gt 0 ];
	then
		runtabbed
	else
		st -e "$xid" "$uri" >/dev/null 2>&1 &
	fi
fi

