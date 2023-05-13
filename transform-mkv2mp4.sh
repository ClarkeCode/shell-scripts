#!/usr/bin/bash

#Requires ffmpeg

for targetfile in "$@"; do
	outputfile="${targetfile%.mkv}.mp4"
	if [ -f "$outputfile" ]; then
		echo "$outputfile already exists, skipping..."
	else
		ffmpeg -loglevel error -stats -i "$targetfile" -c copy "$outputfile"
	fi
done

