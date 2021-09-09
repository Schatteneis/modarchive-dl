#!/bin/bash
useropt='Choose Option: '
choicemen=("User Upload" "User Favorite" "Random Track" "Exit")
select opt in "${choicemen[@]}"; do
    case $opt in
        "User Favorite")
            echo "User ID (query=):"
            read userid
            echo "Getting $userid's info..."
            wget -q -nc "https://modarchive.org/index.php?request=view_member_favourites_text&query=$userid" -O $userid.txt
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
                echo Downloading $filename...
                wget -q -nc --show-progress $url -O $filename
                done
            rm $userid.txt
            exit
            ;;
        "User Upload")
            echo "User ID (query=):"
            read userid
            echo "Getting $userid's info..."
            wget -q -nc "https://modarchive.org/index.php?request=view_artist_modules_text&query=$userid" -O $userid.txt
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
                echo Downloading $filename...
                wget -q -nc --show-progress  $url -O $filename
                done
            rm $userid.txt
            exit
            ;;
        "Exit")
        exit
        ;;
        "Random Track")
            echo "Number of files to download:"
            read randfiles
            while [ $randfiles -gt 0 ]
            do
                echo Getting Random MOD from Server...
                wget -q -nc "https://modarchive.org/index.php?request=view_random" -O rand.txt
                url=$(sed -nr '/downloads.php/ s/.*downloads.php([^"]+).*/\1/p' rand.txt)
                IFS="#" read name filename <<< "$url"
                echo Downloading $filename...
                wget -q -nc --show-progress "https://api.modarchive.org/downloads.php$url" -O $filename
                rm rand.txt
                ((randfiles--))
            done
            exit
        ;;
        *) echo "invalid $REPLY";;
    esac
done