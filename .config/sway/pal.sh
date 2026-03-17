#!/bin/sh
set -eu

trim() {
  sed 's/^ *//;s/ *$//'
}

calendar=$(cal "$@" --color=always -3c1)
prev=$(printf '%s' "$calendar" | tail -n +03 | head -n 6 | trim)
curr=$(printf '%s' "$calendar" | tail -n +11 | head -n 6 | trim)
next=$(printf '%s' "$calendar" | tail -n +19 | head -n 6 | trim)

prev=$(printf '%s' "$prev" | tail -n 1)
next=$(printf '%s' "$next" | head -n 2)

if [ "${#prev}" -eq 20 ]; then
  prev=''
fi

printf '%s' "$calendar" | tail -n +9 | head -n 2
j=0
i=0
printf '\e[90m'
for number in $prev x $curr y $next; do
  case $number in
    x) printf '\e[0m'; continue ;;
    y) printf '\e[90m'; continue ;;
    *) ;;
  esac

  if [ $i -gt 0 ]; then printf ' '; fi
  if [ "${#number}" -lt 2 ]; then
    printf '%02d' "$number" | sed 's/^0/ /'
  else
    printf '%s' "$number"
  fi
  i=$((i + 1))
  if [ $i -ge 7 ]; then
    j=$((j + 1))
    i=0
    printf '\n'
  fi
  if [ $j -ge 6 ]; then break; fi
done
printf '\e[0m'
