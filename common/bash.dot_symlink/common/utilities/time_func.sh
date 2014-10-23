#!/usr/bin/env bash

#echo $(((10#$h*60*60*1000)+(10#$m*60*1000)+(10#$s*1000)+10#$ms))
function ts_get_msec() {
  read -r h m s ms <<< $(echo $1 | tr '.:' ' ' )
  echo $(((10#$h*3600000)+(10#$m*60000)+(10#$s*1000)+10#$ms))
}
