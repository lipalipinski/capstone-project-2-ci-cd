#!/bin/bash

# check if server responds with 200 on any of url passed in args

interval=5
tout=300

for (( i=0; i<$tout; i+=$interval ))
do 
  for url in "$@"
  do
    resp=$(curl -s -I "$url" | grep "HTTP/1.1")
    if [[ $resp == *"200"* ]]
    then
      echo "$url"
      echo "$resp"
      exit 0
    fi
  done
  echo "waiting... $(( $i + $interval ))s"
  sleep $interval
done

echo "$resp"
echo "Site unavailable at $url"
exit 62