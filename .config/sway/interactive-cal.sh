#!/bin/sh
set -eu

program="cal"
while getopts "b:" opt; do
    case "$opt" in
        b) program="$OPTARG" ;;
        *) echo "usage: $0 [-b program]" >&2; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

month=$(date +%-m)
year=$(date +%Y)

original_month=$month
original_year=$year

selected_index=0

printf '\033[?1049h' # switch to alternate screen buffer
printf '\033[?25l' # hide cursor

#      |--------------------|
legend='[jk] [r]         [q]'

read_key() {
  old=$(stty -g)
  stty raw -echo
  key=$(dd bs=1 count=1 2>/dev/null)
  stty "$old"
}

#initial_state=$("$program" "$month" "$year" | sed -n '3,8p' | sed 's/^/ /')

redraw=1
while true; do
  if [ $redraw -eq 1 ]; then
    printf '\033[H'
    "$program" "$month" "$year"
    printf '\033[7;37m%s\033[0m' "$legend"
  fi;

  read_key

  redraw=1
  case "$key" in
    q) break ;;
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
printf '\033[?1049l' # restore original screen buffer
