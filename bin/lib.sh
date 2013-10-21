#!/bin/bash
#####################################################################
# Ce script facilite la coloration du texte dans le terminal.       #
#####################################################################

#0=>normal  1=> gras 2=>faible 4=>souligner 7=>surligner
#8=> invisible 9=>barré
#31=>rouge  32=>vert  33=>jaune  34=>bleue
#35=>violet  36=>cyan  37=>gris
#4X => change le fond

function video
{
  printf "\033[%sm" $1
}
function echo_clr
{
  video $1
    video $2
    echo $3
    video
}

VERT="\E[32;40m"
BLANC="\E[37;40m"
ROUGE="\E[31;40m"

ALIGNR="\e[$((${COLUMNS:-"$(tput cols)"}-10))G" # Align right
OK="$ALIGNR $VERT [OK] $BLANC"
FAIL="$ALIGNR $ROUGE [FAIL] $BLANC"


