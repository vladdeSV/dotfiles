#!/usr/bin/env zsh
month=$(date +%-m)
year=$(date +%Y)

original_month=$month
original_year=$year

printf '\e[?1049h' # switch to alternate screen buffer
printf '\e[?25l' # hide cursor

#      |--------------------|
legend='[jk] [r]         [q]'

while true; do
  printf '\e[H'
  ~/.config/sway/fal.sh "$month" "$year"
  printf '\e[7;37m'"$legend"'\e[0m'
  read -sk 1 key

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
  esac
done

printf '\e[?25h' # show cursor
printf '\e[?1049l' # restore original screen buffer
