#!/bin/bash
#Download all of the images in the provided webpage to the specified destination

webpage="$1"
dldestination="$2"

if [ -z "$webpage" ] || [ -z "$dldestination" ]; then
	echo "Usage: $0 webpage destinationfolder"
	exit 1
fi

cd "$dldestination" && curl -s "$webpage" | sed -E "s#(</div>)|(href=\")#\n#g;" | sed "s/\"/\n/" | grep "^//i.4cdn.org" | uniq | while read pic; do curl https:"$pic" -O -s; done && cd "$OLDPWD"
