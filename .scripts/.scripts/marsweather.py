#!/usr/bin/env python
from json import loads
from requests import get
from datetime import datetime

URL = "http://marsweather.ingenology.com/v1/latest"

req = get(URL)
weather_data = loads(req.text)

degree_sign = u'\N{DEGREE SIGN}'
temp = (int(weather_data['report']['max_temp']) +\
        int(weather_data['report']['min_temp']))/2
date = datetime.strptime(weather_data['report']['terrestrial_date'], "%Y-%m-%d").strftime('%b %d, %Y')

print("It is currently %s%sC on Mars. Last updated %s." % (temp, degree_sign, date))
