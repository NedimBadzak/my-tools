#!/bin/bash
# Usage: checksite.sh <URL> <interval in seconds>                                                                     
# or checksite.sh

first="false"
re='^[0-9]+$'

if [ -f "$HOME/.config/zamgeras/config.json" ]; then
	first="false"
else
	first="true"
fi

if [ $first == "true" ] ; then
	read -p "Molimo unesite zamger link: " uneseniSite
	read -p "Koliko cesto zelite provjeru? Unesite u sekundama: " uneseniInterval
	if ! [[ $uneseniInterval =~ $re ]] ; then
   		echo "Error: Nije broj" >&2; exit 1
	fi

	JSON_STRING=$( jq -n \
		--arg us "$uneseniSite" \
		--arg ui "$uneseniInterval" \
		'{site: $us, interval: $ui}' )

	echo $JSON_STRING > "$HOME/.config/zamgeras/config.json"
fi

site="http://zamger.etf.unsa.ba/"                                                                         
interval="60"
if [ $# -eq 0 ] || [ -z "$1" ] || [ -z "$2" ] ; then

	site=$(jq -r .site "$HOME/.config/zamgeras/config.json")
	interval=$(jq -r .interval "$HOME/.config/zamgeras/config.json")

	if ! [[ $interval =~ $re ]] ; then
   		echo "Error: Nije broj" >&2; exit 1
	fi

else

	echo "Koristenje podataka iz parametara umjesto configa"

	site=$1
	interval=$2

	if ! [[ $interval =~ $re ]] ; then
   		echo "Error: Nije broj" >&2; exit 1
	fi
fi

get_cmd='curl -s'                                                               
contents=$( $get_cmd $site )                                                    
subject="Nova zamger objava"                                                         
while true ; do                                                                 
    new_contents=$( $get_cmd $site )                                            
    if [ "$contents" != "$new_contents" ] ; then                                
        diff <(echo "$contents") <(echo "$new_contents") | notify-send "$subject"                                   
        contents=$new_contents                                                                    
    else                                                                        
        contents=$new_contents                                                  
    fi                                                                          
    sleep $interval                                                                     
done
