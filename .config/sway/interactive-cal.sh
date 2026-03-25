#!/bin/sh
set -eu

program="cal"
hide_bar=0
while getopts "b:s" opt; do
    case "$opt" in
        b) program="$OPTARG" ;;
        s) hide_bar=1 ;;
        *) echo "usage: $0 [-s] [-b program]" >&2; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

day=$(date +%-d)
month=$(date +%-m)
year=$(date +%Y)

original_month=$month
original_year=$year
offset=0


#      |--------------------|
legend='[jk] [r]         [q]'

input="$(cat)"

read_key() {
  old=$(stty -g < /dev/tty)
  stty raw -echo < /dev/tty
  key=$(dd bs=1 count=1 2>/dev/null < /dev/tty)
  stty "$old" < /dev/tty
}

# initial draw, to handle relative cursor movement
redraw=1
first_print=1

printf '\033[?25l' # hide cursor
while true; do
  if [ $redraw -eq 1 ]; then

    cal_output=$(printf '%s' "$input" | "$program" --offset="$offset" "$day" "$month" "$year" 3>&1)
    extra=$(printf '%s' "$cal_output" | tail -n +9)
    cal_output=$(printf '%s' "$cal_output" | head -n 8)

    output=$(echo "$cal_output"; if [ "$hide_bar" -eq 0 ]; then printf '\033[7;37m%s\033[0m\r' "$legend"; fi)

    move_up_lines=$(printf '%s' "$output" | wc -l)
    move_back_cols=$(echo "$output" | head -n 1 | wc -m)
    move_back_cols=$((move_back_cols - 2))

    if [ $first_print -eq 1 ]; then
      first_print=0
    else
      printf '\033[%dA\033[%sD' "$move_up_lines" "$move_back_cols"
    fi
    printf '%s' "$output"
    if [ -n "$extra" ]; then
      if [ "${#extra}" -gt 20 ]; then
        extra="$(printf '%s' "$extra" | cut -c1-20)…"
      fi
      printf '%s' "$extra"
    fi
  fi;

  read_key

  redraw=1
  case "$key" in
    n) ;;
    q) echo ; break ;;

    h) offset=$((offset - 1)) ;;
    l) offset=$((offset + 1)) ;;
    j) offset=$((offset + 7)) ;;
    k) offset=$((offset - 7)) ;;
    i) offset=$((offset - 28)) ;;
    u) offset=$((offset + 28)) ;;
    r) offset=0 ;;
    *) redraw=0 ;;
  esac
done

printf '\033[?25h' # show cursor
