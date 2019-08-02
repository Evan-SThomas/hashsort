#!/bin/bash

#Set limit for hashes, this determines the fraction of data in each set.
hashlimit=$( echo "obase=2;ibase=16;63" | bc -l)
#Move into the data directory.
cd $1
#Make train and test data directories.
mkdir ../traindata
mkdir ../testdata
#Takes a summary of what's there.
flo=$( ls )
#Splits list by whitespace
fl=($(echo $flo | tr " " "\n"))
#For each file in the data directory:
for i in "${fl[@]}"
do
#	Calculate the sha256 hash
	dumhash=$( sha256sum $i)
#	Split by whitespace.
	IFS=' ' read -ra dumhash <<< "$dumhash"
#	Pick the hash part of the result.
	dumhash=${dumhash[0]}
#	Convert lowercase letters to uppercase. Also only keeps last two digits
	hexhash=$( echo ${dumhash:62} | tr [:lower:] [:upper:] )
#	Convert hex number to binary representation.
	binhash=$( echo "obase=2;ibase=10;$hexhash" | bc -l)
#	If the result is sorted according to wheter it's above or below the hash limit.
	if [ $binhash -lt $hashlimit ]
	then
		mv $i ../traindata
	else
		mv $i ../testdata
	fi
done
#Results are printed to the terminal.
echo "less than: "
echo $( ls ../traindata -1 | wc -l )
echo "more than: "
echo $( ls ../testdata -1 | wc -l )
