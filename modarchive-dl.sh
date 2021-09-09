#!/bin/bash
userid=$1
wget "https://modarchive.org/index.php?request=view_member_favourites_text&query=$userid" -O $userid.txt
lines=$(echo 39)
while [ $lines -gt 0 ]
do
    sed -i '$ d' $userid.txt
    ((lines--))
done
sed -i -e '1,179d' $userid.txt
for url in $(cat $userid.txt)
do 
    IFS="#" read name filename <<< "$url"
    wget $url -O $filename
    done
rm $userid.txt
