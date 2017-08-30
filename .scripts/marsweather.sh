#!/bin/bash
data=$(curl --silent http://marsweather.ingenology.com/v1/latest/ | jq '.report')
date=$(date -d $(echo $data | jq .terrestrial_date | tr -d '"') +'%b %d, %Y')
temp=$((($(echo $data | jq .min_temp) + $(echo $data | jq .max_temp))/2))

echo "The temperature on mars is $temp°C. Last updated $date."
