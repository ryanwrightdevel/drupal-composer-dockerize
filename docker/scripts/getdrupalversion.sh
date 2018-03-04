#!/usr/bin/env bash
content=$(wget http://updates.drupal.org/release-history/drupal/7.x -q -O -)
#echo $content




v=$(xpath '/project/releases/release[1]/version' <<< $content )

v=$(sed -e 's/<[^>]*>//g' <<< $v )
v=$(sed -e 's/-- NODE --//g' <<< $v )
v=$(echo $v | sed "1,5d"  )
echo $v