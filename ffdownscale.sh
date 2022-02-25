#/usr/bin/sh
#ffmpeg and ffprobe are dependancies
#Script to lower the quality of a video below a specified file size

if [ $# -lt 3 ]; then
	echo "usage: ffdownscale input output size
		Note: size in megabytes"
	exit 2
fi

BITS_PER_MEGABYTE=$(( 8 * 1000 * 1000 ))
size=$3

time=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $1)


bitrate=$(echo "($size * $BITS_PER_MEGABYTE) / $time" | bc)
#Note: the buffer size calculation is from https://unix.stackexchange.com/a/598360
buffersize=$(echo "$size * $BITS_PER_MEGABYTE / 200" | bc )
echo "Calculated bitrate at: $bitrate bits/sec"
echo "Buffsize = $buffersize"
echo "Beginning conversion, this may take a few minutes"
ffmpeg -i $1 -maxrate $bitrate -bufsize $buffersize $2 -loglevel error
echo "Conversion done"
