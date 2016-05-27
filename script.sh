#/bin/bash

dstart=2016-03-01
dend=2016-03-25
# convert in seconds sinch the epoch:
start=$(date -d$dstart +%s)
end=$(date -d$dend +%s)
cur=$start

while [ $cur -le $end ]; do
    # convert seconds to date:
    actual=$(date -d@$cur +%Y/%m/%d)
    actualName=$(date -d@$cur +%Y-%m-%d)
    echo "Inizio il download di $actual"
    wget -qO- "https://www.wunderground.com/history/airport/LIRF/$actual/DailyHistory.html?req_city=Fiumicino&req_statename=Italy&reqdb.zip=00000&reqdb.magic=3&reqdb.wmo=16242&format=1" | tr ',' ';' | awk 'BEGIN{FS="<br"} {print $1}' > "$actualName.csv"

    echo "$actual Scaricato!"
    let cur+=24*60*60
done
