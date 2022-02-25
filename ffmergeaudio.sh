#/usr/bin/sh
#ffmpeg is a dependancy
#Also can specify files to merge via stdin
function usage {
	echo "Usage: $0 -o outputfile files..."
}

verbose=""
declare -a inputfiles
while [ "$1" != "" ]; do
	case $1 in
		-o | --output )
			shift
			outputname=$1
			;;
		-v )
			verbose="True"
			;;
		* )
			inputfiles+=($1)
			;;
	esac
	shift
done

#Read from stdin
if [ -p /dev/stdin ]; then
	while IFS= read line; do
		inputfiles+=("$line")
	done
fi

fileMergeNum="${#inputfiles[@]}"

if [ -z "$outputname" ]; then
	echo "ERROR: Must specify an output name"
	usage
	exit 1
elif [ "$fileMergeNum" == 0 ]; then
	echo "ERROR: No files"
	usage
	exit 1
fi

echo "Merging $fileMergeNum files, this may take a moment"

acc=" "
for filename in "${inputfiles[@]}"; do
	acc="$acc-i \"$filename\" "
done

if [ -n "$verbose" ]; then
	echo "ffmpeg -loglevel error "$acc" -filter_complex amix=inputs=$fileMergeNum:duration=longest $outputname"
fi

eval "ffmpeg -loglevel error "$acc" -filter_complex amix=inputs="$fileMergeNum":duration=longest $outputname"

#ffmpeg -i 1_2.mp3 -i 2_2.mp3 -i 3_2.mp3 -i 4_3.mp3  -filter_complex amix=inputs=4:duration=longest OutputName.mp3
