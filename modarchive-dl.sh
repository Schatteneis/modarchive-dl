#!/bin/bash
useropt='Choose Option: '
choicemen=("User Upload" "User Favorite" "Exit")
select opt in "${choicemen[@]}"; do
    case $opt in
        "User Favorite")
            echo "User ID (query=)"
            read userid
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
            ;;
        "User Upload")
            echo "User ID (query=)"
            read userid
            wget "https://modarchive.org/index.php?request=view_artist_modules_text&query=$userid" -O $userid.txt
            lines=$(echo 39)
            while [ $lines -gt 0 ]
            do
                sed -i '$ d' $userid.txt
                ((lines--))
            done
            sed -i -e '1,185d' $userid.txt
            for url in $(cat $userid.txt)
            do 
                IFS="#" read name filename <<< "$url"
                wget $url -O $filename
                done
            rm $userid.txt
            ;;
        "Exit")
        exit
        ;;
        *) echo "invalid $REPLY";;
    esac
done