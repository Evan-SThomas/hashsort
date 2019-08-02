#!/bin/bash
#cp ~/pytt/geo/adata_100k_20w/data/plt99* ~/pytt/hashsort/dumdata/
hashlimit=$( echo "obase=2;ibase=16;63" | bc -l)
#cp $1 $2
cd dumdata
flo=$( ls )
#echo "${flo[@]}"
#flo="dumdata1 dumdata2 dumdata3"
fl=($(echo $flo | tr " " "\n"))

for i in "${fl[@]}"
do
	dumhash=$( sha256sum $i)
	IFS=' ' read -ra dumhash <<< "$dumhash"
	dumhash=${dumhash[0]}
	hexhash=$( echo ${dumhash:62} | tr [:lower:] [:upper:] )
	binhash=$( echo "obase=2;ibase=10;$hexhash" | bc -l)
	if [ $binhash -lt $hashlimit ]
	then
		mv $i ../dd1
		#echo $i
		#echo $hexhash
		#echo $binhash
		#echo blahblah1
	else
		mv $i ../dd2
	#	echo $i
	#	echo $hexhash
	#	echo $binhash
	#	echo blahblah2
	fi
done
echo "less than: "
echo $( ls /home/et/pytt/hashsort/dd1 -1 | wc -l )
echo "more than: "
echo $( ls /home/et/pytt/hashsort/dd2 -1 | wc -l )


cd ~/pytt/hashsort/dd1
mv * ../dumdata
cd ~/pytt/hashsort/dd2
mv * ../dumdata
#echo $my_string
#echo $( pwd )


#hexhasho=${my_array[0]}
##echo $binhash
#for i in fl 
#do
#	if [ $binhash -lt $hashlimit ]
#	then
#		echo ooo
#	fi
#done













#for x in $fl
#do
#	shadum=$( sha256sum $x )
#	if [ $shadum -gt 01 ]
#	then
#		echo $shadum
#	fi
#	
#done
#
