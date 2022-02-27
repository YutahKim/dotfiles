#!/bin/zsh
var=$(( ( RANDOM % 110 )  + 1 ))

#/home/yutah/.local/bin/pixcat resize --min-width 50 --min-height 50 \
#             --max-width 50 --max-height 50 \
#            -a left "/home/yutah/Pictures/banners/heroes/hero $var

#/home/yutah/.local/bin/pixcat thumbnail --size 50 -r nearest -a left "/home/yutah/Pictures/banners/heroes/hero $var.png"
chafa -s 8 "/home/yutah/Pictures/banners/heroes/hero $var.png"

#/home/yutah/.local/bin/pixcat "/home/yutah/Pictures/banners/heroes/hero $var.png"
#viu -t -b -w 10 -h 5 "/home/yutah/Pictures/banners/heroes/hero $var.png"
