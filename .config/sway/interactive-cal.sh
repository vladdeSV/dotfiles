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

month=$(date +%-m)
year=$(date +%Y)

original_month=$month
original_year=$year


#      |--------------------|
legend='[jk] [r]         [q]'

read_key() {
  old=$(stty -g)
  stty raw -echo
  key=$(dd bs=1 count=1 2>/dev/null)
  stty "$old"
}

# initial draw, to handle relative cursor movement
redraw=1
first_print=1

printf '\033[?25l' # hide cursor
while true; do
  if [ $redraw -eq 1 ]; then
    output=$("$program" --color=always "$month" "$year"; if [ "$hide_bar" -eq 0 ]; then printf '\033[7;37m%s\033[0m\r' "$legend"; fi)
    move_up_lines=$(printf '%s' "$output" | wc -l)
    move_back_cols=$(echo "$output" | head -n 1 | wc -m)
    move_back_cols=$((move_back_cols - 2))

    if [ $first_print -eq 1 ]; then
      first_print=0
    else
      printf '\033[%dA\033[%sD' "$move_up_lines" "$move_back_cols"
    fi
    printf '%s' "$output"
  fi;

  read_key

  redraw=1
  case "$key" in
    n) ;;
    q) echo ; break ;;
    k)
      month=$((month - 1))
      if [ "$month" -lt 1 ]; then
        month=12
        year=$((year - 1))
      fi
      ;;
    j)
      month=$((month + 1))
      if [ "$month" -gt 12 ]; then
        month=1
        year=$((year + 1))
      fi
      ;;
    r)
      month=$original_month
      year=$original_year
      ;;
    *) redraw=0 ;;
  esac
done

printf '\033[?25h' # show cursor
