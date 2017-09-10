#!/bin/sh
# Set Linux Terminal Colors
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P01D1f21
  \e]P1DC2566
  \e]P28FC029
  \e]P3D4C96e
  \e]P455BCCE
  \e]P59358FE
  \e]P656b7A5
  \e]P7C5C8C6
  \e]P876715E
  \e]P9FA2772
  \e]PAA7E22e
  \e]PBE7DB75
  \e]PC66D9EE
  \e]PDAE82FF
  \e]PE66EFD5
  \e]PFACADA1
  "
   clear
fi
