#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: "$0 "<file>..."
	exit 1
fi

function convert {

	url="https://json-csv.com"
	href=$(
		curl -s 'https://json-csv.com/conversion/start' -F=@$1 \
			| jq .href | sed 's/"//g'
	)

	url+=$href

	curl -s -A 'Googlebot' "$url" -o ${1/xml/csv}
}


for i in "$@"; do

	if [ ! -f $i ]; then
		echo "ERROR: $i is not a file."
		continue
	fi

	echo -n "Converting: \"$i\"..."
	convert $i && echo -e "\tSUCCESS" || echo -e "\tFAILED"

done
