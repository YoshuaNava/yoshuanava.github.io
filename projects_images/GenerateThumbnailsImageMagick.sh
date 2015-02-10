#! /bin/bash

for fileName in $( ls ); do
	$( convert -thumbnail 480 $fileName thumb.$fileName )
	if [ $? -eq 0 ]; then
		echo "$fileName thumbnail generated."
	else
		echo "$fileName thumbnail generation ERROR."
	fi
done
