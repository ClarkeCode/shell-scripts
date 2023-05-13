#!/usr/bin/bash

#Requires the 'youtube-upload' utility
#https://github.com/tokland/youtube-upload

for file in "$@"; do
	read -e -p 'Desired Title: ' -i "${file%.mp4}" title
	read    -p 'Description: ' description
	read -e -p 'Visibility (public | unlisted | private): ' -i "unlisted" privacy

	#echo "'$title'"
	#echo "'$description'"
	#echo "'$privacy'"
	youtube-upload --title="$title" --description="$description" --privacy="$privacy" "$file"
done
